{ pkgs ? import <nixpkgs> {}, commonCmakeFlags ? [] }:
let                 
  inherit (pkgs) 
    stdenv
    fetchurl
    ;
in
  stdenv.mkDerivation {
    pname = "lua-compat53";
    version = "0.13";

    src = fetchurl {
      url = "https://github.com/lunarmodules/lua-compat-5.3/archive/v0.13.tar.gz";
      sha256 = "f5dc30e7b1fda856ee4d392be457642c1f0c259264a9b9bfbcb680302ce88fc2";
    };
    phases = [ "unpackPhase" "installPhase" ];

    installPhase = ''
      mkdir -p $out
      cp -R * $out
    '';
}
