{stdenv, buildFractalideContract, upkeepers
  , command
  , ...}:

buildFractalideContract rec {
  src = ./.;
  importedContracts = [ command ];
  contract = ''
  @0xafd2d34a29d48dbd;
  using Command = import "${command}/src/contract.capnp";

  struct ShellCommands {
    commands @0 :List(Command.Command);
  }
  '';

  meta = with stdenv.lib; {
    description = "Contract: Mappings used to convert a complex hierarchical name such as 'shell_commands_cd' to 'cd'.";
    homepage = https://github.com/fractalide/fractalide/tree/master/contracts/shells/commands;
    license = with licenses; [ mpl20 ];
    maintainers = with upkeepers; [ dmichiels sjmackenzie];
  };
}
