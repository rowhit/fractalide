{ pkgs, support, contracts, components, ... }:
let
callPackage = pkgs.lib.callPackageWith (pkgs // support // contracts // components);
# insert in alphabetical order to reduce conflicts
self = rec {
  example_wrangle = callPackage ./example/wrangle {inherit pkgs support contracts components;};
  app_todo = callPackage ./app/todo {inherit pkgs support contracts components;};
  app_todo_controller = callPackage ./app/todo/controller {inherit pkgs support contracts components;};
  app_todo_model = callPackage ./app/todo/model {inherit pkgs support contracts components;};
  nanomsg = callPackage ./nanomsg {inherit pkgs support contracts components;};
  net_http = callPackage ./net/http {inherit pkgs support contracts components;};
  net_ndn = callPackage ./net/ndn {inherit pkgs support contracts components;};
  ui_js = callPackage ./ui/js {inherit pkgs support contracts components;};
  workbench = callPackage ./workbench {inherit pkgs support contracts components;};
};
in
self
