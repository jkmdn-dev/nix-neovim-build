{ pkgs ? import <nixpkgs> {}, commonCmakeFlags ? [
    "-DBUILD_SHARED_LIBS=OFF"
     "-DCMAKE_POSITION_INDEPENDENT_CODE=ON"
  ] }:
let                 
  parserLang = "lua";
  version = "0.0.19";
  src = {
    url = "https://github.com/tree-sitter-grammars/tree-sitter-lua/archive/v0.0.19.tar.gz";
    sha256 = "974230f212d0049fce8e881b88b18eebbd05f1fd0edd16fe4ba5bdd2bcd78d08";
  };
in
  pkgs.callPackage ./parser.nix { inherit pkgs parserLang version src commonCmakeFlags; }
