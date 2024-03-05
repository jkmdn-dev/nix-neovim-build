{ pkgs ? import <nixpkgs> {}, commonCmakeFlags ? {} }:
let
  inherit (pkgs)
    stdenv
    fetchurl
    cmake
    ninja
    ;
  ts_cmake = ./cmake/TreesitterCMakeLists.txt;
in
  stdenv.mkDerivation {
    pname = "treesitter";
    version = "0.21.0";

    src = fetchurl {
      url = "https://github.com/tree-sitter/tree-sitter/archive/v0.21.0.tar.gz";
      sha256 = "6bb60e5b63c1dc18aba57a9e7b3ea775b4f9ceec44cc35dac4634d26db4eb69c";
    };

    nativeBuildInputs = [ cmake ninja ];

    cmakeFlags = commonCmakeFlags;

    postUnpack =
      ''
        cp ${ts_cmake} $sourceRoot/CMakeLists.txt
      '';
}

