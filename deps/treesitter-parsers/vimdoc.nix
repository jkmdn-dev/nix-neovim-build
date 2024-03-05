{ pkgs ? import <nixpkgs> {}, commonCmakeFlags ? [
    "-DBUILD_SHARED_LIBS=OFF"
     "-DCMAKE_POSITION_INDEPENDENT_CODE=ON"
  ] }:
let
  parserLang = "vimdoc";
  version = "2.1.0";
  src = {
    url = "https://github.com/neovim/tree-sitter-vimdoc/archive/v2.1.0.tar.gz";
    sha256 = "71af795090ff50638904f27b8888ba1c0c2be91b7b60b0a6f2d6d6a138150e02";
  };
in
  pkgs.callPackage ./parser.nix { inherit pkgs parserLang version src commonCmakeFlags; }
