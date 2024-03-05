{ pkgs ? import <nixpkgs> {}, commonCmakeFlags ? [
    "-DBUILD_SHARED_LIBS=OFF"
     "-DCMAKE_POSITION_INDEPENDENT_CODE=ON"
  ] }:
let
  parserLang = "query";
  version = "0.1.0";
  src = {
    url = "https://github.com/tree-sitter-grammars/tree-sitter-query/archive/v0.1.0.tar.gz";
    sha256 = "e2b806f80e8bf1c4f4e5a96248393fe6622fc1fc6189d6896d269658f67f914c";
  };
in
  pkgs.callPackage ./parser.nix { inherit pkgs parserLang version src commonCmakeFlags; }
