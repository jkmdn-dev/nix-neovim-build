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
		pname = "msgpack";
		version = "6.0.0";

		src = fetchurl {
			url = "https://github.com/msgpack/msgpack-c/archive/c-6.0.0.tar.gz";
			sha256 = "af6f3cf25edb220aa2140b09bb5bdd73ddf00938194bd94ebe5c92090cccb466";
		};

		nativeBuildInputs = [ cmake ninja ];
		
		cmakeFlags = [
			"-DMSGPACK_BUILD_TESTS=OFF"
			"-DMSGPACK_BUILD_EXAMPLES=OFF"
		] ++ commonCmakeFlags;
}
