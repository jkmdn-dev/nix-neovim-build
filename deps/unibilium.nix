{ pkgs ? import <nixpkgs> {}, commonCmakeFlags ? {} }:
let                 
  inherit (pkgs) 
    stdenv
    fetchurl
    cmake
    ninja
    ;  
in
  stdenv.mkDerivation {
    pname = "unibilium";
    version = "unknown-version";

    src = fetchurl {
      url = "https://github.com/neovim/unibilium/archive/d72c3598e7ac5d1ebf86ee268b8b4ed95c0fa628.tar.gz";
      sha256 = "9c4747c862ab5e3076dcf8fa8f0ea7a6b50f20ec5905618b9536655596797487";
    };

    nativeBuildInputs = [ cmake ninja ];

    cmakeFlags = commonCmakeFlags;
}
