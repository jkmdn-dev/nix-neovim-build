{ pkgs ? import <nixpkgs> {}, parserLang, version, src, cmakeFile ? ./cmake/TreesitterParserCMakeLists.txt, commonCmakeFlags ? [
    "-DBUILD_SHARED_LIBS=OFF"
     "-DCMAKE_POSITION_INDEPENDENT_CODE=ON"
  ] }:
let
  inherit (pkgs)
    cmake
    ninja
    stdenv
    fetchurl
    ;
in
  stdenv.mkDerivation {
    inherit version;
    pname = "treesitter-${parserLang}";
    src = fetchurl src;
    postUnpack = "cp ${cmakeFile} $sourceRoot/CMakeLists.txt";
    nativeBuildInputs = [ cmake ninja ];
    cmakeFlags = [
      "-DPARSERLANG=${parserLang}"
    ] ++ commonCmakeFlags;
}
