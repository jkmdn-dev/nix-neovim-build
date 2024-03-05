{ pkgs ? import <nixpkgs> {}, commonCmakeFlags ? []  }:
let                 
  inherit (pkgs) 
    stdenv
    fetchurl
    cmake
    ninja
    ;  
  libvterm_cmake = ./cmake/LibvtermCMakeLists.txt;
in
  stdenv.mkDerivation {
    pname = "libvterm";
    version = "0.3.3";

    src = fetchurl {
      url = "https://github.com/neovim/libvterm/archive/v0.3.3.tar.gz";
      sha256 = "0babe3ab42c354925dadede90d352f054aa9c4ae6842ea803a20c9741e172e56";
    };

    cmakeFlags = commonCmakeFlags;

    nativeBuildInputs = [ cmake ninja ];

    postUnpack =
      ''
        cp ${libvterm_cmake} $sourceRoot/CMakeLists.txt
      '';
}

