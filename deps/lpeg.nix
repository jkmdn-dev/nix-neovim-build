{ pkgs ? import <nixpkgs> {}, commonCmakeFlags ? [] }:
let                 
  inherit (pkgs) 
    stdenv
    fetchurl
    callPackage
    cmake
    ninja
    ;

  luajit =  callPackage ./luajit.nix { inherit pkgs; }; #dosen't use cmake, don't need cmakeFlags
  lpeg_cmake = ./cmake/LpegCMakeLists.txt;
in
  stdenv.mkDerivation {
    pname = "lpeg";
    version = "1.1.0";

    src = fetchurl {
      url = "https://github.com/neovim/deps/raw/d495ee6f79e7962a53ad79670cb92488abe0b9b4/opt/lpeg-1.1.0.tar.gz";
      sha256 = "4b155d67d2246c1ffa7ad7bc466c1ea899bbc40fef0257cc9c03cecbaed4352a";
    };

    cmakeFlags = commonCmakeFlags;

    nativeBuildInputs = [ cmake ninja ];
    buildInputs = [ luajit ];

    postUnpack=
      ''
        cp ${luajit}/include/luajit-2.1/*.h $sourceRoot
        cp ${lpeg_cmake} $sourceRoot/CMakeLists.txt
      '';
}
