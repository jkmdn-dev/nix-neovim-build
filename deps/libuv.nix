{ pkgs ? import <nixpkgs> {}, commonCmakeFlags ? [] }:
let
  inherit (pkgs)
    stdenv
    fetchurl
    cmake
    ninja
    ;
in
  stdenv.mkDerivation {
    pname = "libuv";
    version = "1.48.0";

    src = fetchurl {
      url = "https://github.com/libuv/libuv/archive/v1.48.0.tar.gz";
      sha256 = "8c253adb0f800926a6cbd1c6576abae0bc8eb86a4f891049b72f9e5b7dc58f33";
    };

    cmakeFlags = [
      "-DCMAKE_INSTALL_LIBDIR=lib"
      "-DBUILD_TESTING=OFF"
      "-DLIBUV_BUILD_SHARED=OFF"
      "-DUV_LINT_W4=OFF"
    ] ++ commonCmakeFlags;

    nativeBuildInputs = [ cmake ninja ];
}

