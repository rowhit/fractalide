extern crate capnp;

#[macro_use]
extern crate rustfbp;
use rustfbp::component::*;

mod contracts {
    include!("file.rs");
}

use self::contracts::file;

component! {
    file_open,
    inputs(input: path),
    inputs_array(),
    outputs(output: file),
    outputs_array(),
    option(),
    acc(),
    fn run(&mut self) {

        // Get one IP
        let mut ip = self.ports.recv("input".into()).expect("file_print : unable to receive from input");
        let file = ip.get_reader().expect("file_open: cannot get the reader");
        let file: file::Reader = file.get_root().expect("file_open: not a file_name reader");
        // Send outside (don't care about loss)
        let _ = self.ports.send("output".into(), ip);
        // print it
        match file.which().expect("cannot which") {
            file::Start(path) => {
                println!("Start : {} ", path.unwrap());
                loop {
                    // Get one IP
                    let mut ip = self.ports.recv("input".into()).expect("file_print : unable to receive from input");
                    let file = ip.get_reader().expect("file_open: cannot get the reader");
                    let file: file::Reader = file.get_root().expect("file_open: not a file_name reader");
                    // Send outside (don't care about loss)
                    let _ = self.ports.send("output".into(), ip);

                    match file.which().expect("cannot which") {
                      file::Text(text) => { println!("Text : {} ", text.unwrap()); },
                      file::End(path) => { println!("End : {} ", path.unwrap()); break; },
                        _ => { panic!("bad stream"); },
                    }
                }
            },
            _ => { panic!("bad stream") }
        }

    }
}
