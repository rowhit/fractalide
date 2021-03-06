#[macro_use]
extern crate rustfbp;
extern crate capnp;

use std::fs;

component! {
    nucleus_flow_errors, contracts(fbp_graph, fbp_semantic_error, file_error)
    inputs(file_error: file_error, semantic_error: fbp_semantic_error),
    inputs_array(),
    outputs(output: fbp_graph),
    outputs_array(),
    option(),
    acc(),
    fn run(&mut self) -> Result<()>{

        match self.ports.try_recv("semantic_error") {
            Ok(mut ip) => {
                let error: fbp_semantic_error::Reader = try!(ip.get_root());

                println!("Graph at : {}", try!(error.get_path()));
                let parsing = try!(error.get_parsing());
                for i in 0..parsing.len() {
                    println!("  {}", try!(parsing.get(i)));
                }
                println!("");
            }
            _ => {}
        };

        match self.ports.try_recv("file_error") {
            Ok(mut ip) => {
                let error: file_error::Reader = try!(ip.get_root());
                println!("Subnet doesn't exist at file location : {}\n", try!(error.get_not_found()));
            }
            _ => {}
        };


        let mut new_ip = IP::new();
        {
            let mut ip = new_ip.init_root::<fbp_graph::Builder>();
            ip.set_path("error");
        }
        let _ = self.ports.send("output", new_ip);
        Ok(())
    }
}
