{pkgs, components, contracts, support, ...}:

let
fvm  = support.buildRustPackage rec {
    name = "fvm";
    src = ./.;
    depsSha256 = "0cf3rfw7cxf1sfxviqq80xjjlyjm7g77d1da5vrpivwqyq8d2b7g";
    configurePhase = ''
    runHook preConfigure
    substituteInPlace src/lib.rs --replace "fs_file_open.so" "${components.fs_file_open}/lib/libcomponent.so"
    substituteInPlace src/lib.rs --replace "nucleus_flow_parser_lexical.so" "${components.nucleus_flow_parser_lexical}/lib/libcomponent.so"
    substituteInPlace src/lib.rs --replace "nucleus_flow_parser_semantic.so" "${components.nucleus_flow_parser_semantic}/lib/libcomponent.so"
    substituteInPlace src/lib.rs --replace "nucleus_flow_vm.so" "${components.nucleus_flow_vm}/lib/libcomponent.so"
    substituteInPlace src/lib.rs --replace "nucleus_flow_errors.so" "${components.nucleus_flow_errors}/lib/libcomponent.so"
    substituteInPlace src/lib.rs --replace "nucleus_flow_parser_graph_print.so" "${components.nucleus_flow_parser_graph_print}/lib/libcomponent.so"
    substituteInPlace src/lib.rs --replace "nucleus_flow_parser_graph_check.so" "${components.nucleus_flow_parser_graph_check}/lib/libcomponent.so"
    substituteInPlace src/lib.rs --replace "nucleus_flow_scheduler.so" "${components.nucleus_flow_scheduler}/lib/libcomponent.so"
    substituteInPlace src/lib.rs --replace "nucleus_capnp_encode.so" "${components.nucleus_capnp_encode}/lib/libcomponent.so"
    substituteInPlace src/lib.rs --replace "halter.so" "${components.halter}/lib/libcomponent.so"
    substituteInPlace src/lib.rs --replace "nucleus_find_contract.so" "${components.nucleus_find_contract}/lib/libcomponent.so"
    substituteInPlace src/lib.rs --replace "nucleus_find_component.so" "${components.nucleus_find_component}/lib/libcomponent.so"

    substituteInPlace src/lib.rs --replace "path_capnp.rs" "${contracts.path}/src/contract_capnp.rs"
    substituteInPlace src/lib.rs --replace "fbp_action.rs" "${contracts.fbp_action}/src/contract_capnp.rs"
    '';

    installPhase = ''
      runHook preInstall
    '';

    meta = with pkgs.stdenv.lib; {
      description = "Fractalide Virtual Machine";
      homepage = https://github.com/fractalide/fractalide;
      license = with licenses; [ mpl20 ];
      maintainers = with support.upkeepers; [ dmichiels sjmackenzie ];
  };
};
in
fvm
