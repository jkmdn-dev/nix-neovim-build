{ pkgs ? import <nixpkgs> {}, commonCmakeFlags ? [] }:
let                 
	inherit (pkgs) 
		stdenv
		fetchurl
		callPackage
		cmake
		ninja
		;

	lua_compat53 = callPackage ./lua-compat53.nix { inherit pkgs commonCmakeFlags; };
	luajit = callPackage ./luajit.nix { inherit pkgs commonCmakeFlags; };
	libuv = callPackage ./libuv.nix { inherit pkgs commonCmakeFlags; };
in
	stdenv.mkDerivation {
		pname = "luv";
		version = "1.48.0-1";

		src = fetchurl {
			url = "https://github.com/luvit/luv/archive/1.48.0-1.tar.gz";
			sha256 = "99042665a3fb486b8d0c80d0130e62b918abbad069e908eb333765462245e275";
		};

		nativeBuildInputs = [ cmake ninja lua_compat53 luajit libuv ];

		cmakeFlags = [
			"-DLUA_BUILD_TYPE=System"
			"-DLUA_COMPAT53_DIR=${lua_compat53}"
			"-DWITH_SHARED_LIBUV=ON"
			"-DBUILD_STATIC_LIBS=ON"
			"-DBUILD_MODULE=OFF"
		] ++ commonCmakeFlags;
}

