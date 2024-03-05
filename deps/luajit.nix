{ pkgs ? import <nixpkgs> {}, commonCmakeFlags ? [] }:
let                 
	inherit (pkgs) 
		stdenv
		fetchurl
		makeWrapper
		;
in
	stdenv.mkDerivation {
		pname = "luajit";
		version = "unknown-version";

		src = fetchurl {
			url = "https://github.com/LuaJIT/LuaJIT/archive/0d313b243194a0b8d2399d8b549ca5a0ff234db5.tar.gz";
			sha256 = "53731880dbc4adbbf82ba69a85b5dbe15266032b8b94a077c0835bc10ec75f12";
		};

		buildInputs = [ makeWrapper ];
		
		buildPhase =
			''
				make -j CFLAGS=-fPIC CFLAGS+=-DLUA_USE_APICHECK CFLAGS+=-funwind-tables CCDEBUG+=-g Q= CC=cc
			'';

		installPhase =
			''
				make PREFIX=$out install
				wrapProgram $out/bin/luajit \
				--set LUA_PATH "$out/share/luajit-2.1/?.lua" \
				--set LUA_CPATH "$out/lib/?.so"
			'';
}

