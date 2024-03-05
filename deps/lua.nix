{ pkgs ? import <nixpkgs> {}, commonCmakeFlags ? [] }:
let
  inherit (pkgs)
    stdenv
    fetchurl
    libedit
    gnumake
    makeWrapper;

  LUA_CFLAGS="-O2 -g3 -fPIC";
  LUA_LDFLAGS="";
in
  stdenv.mkDerivation {
    pname = "lua";
    version = "5.1.5";

    src = fetchurl {
      url = "https://www.lua.org/ftp/lua-5.1.5.tar.gz";
      sha256 = "2640fc56a795f29d28ef15e13c34a47e223960b0240e8cb0a82d9b0738695333";
    };

    nativeBuildInputs = [ gnumake makeWrapper libedit ];

    preConfigure = ''
      sed -i "/^CC/ s|gcc|${stdenv.cc.targetPrefix}cc|" src/Makefile
      sed -i "/^CFLAGS/ s|-O2|${LUA_CFLAGS}|" src/Makefile
      sed -i "s|-lreadline||g" src/Makefile
      sed -i "s|-lhistory||g" src/Makefile
      sed -i "s|-lncurses||g" src/Makefile
      sed -i "/^MYLDFLAGS/ s|$|${LUA_LDFLAGS}|" src/Makefile
      sed -i "/#define LUA_USE_READLINE/ d" src/luaconf.h
      sed -i "s|\\(#define LUA_ROOT[   ]*\"\\)/usr/local|\\1${placeholder "out"}|" src/luaconf.h
    '';

    buildPhase = ''
      make linux
    '';

    installPhase = ''
      make TO_BIN="lua luac" INSTALL_TOP=$out install
    '';
}

