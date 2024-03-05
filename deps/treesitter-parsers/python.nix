{ pkgs ? import <nixpkgs> {}, commonCmakeFlags ? [
		"-DBUILD_SHARED_LIBS=OFF"
 		"-DCMAKE_POSITION_INDEPENDENT_CODE=ON"
	]}:
let                 
	parserLang = "python";
	version = "0.20.4";
	src = {
		url = "https://github.com/tree-sitter/tree-sitter-python/archive/v0.20.4.tar.gz";
		sha256 = "1e38c991832f461c0da8ca222fbe5be3b82b868fe34025f0295206b5e5789d7a";
	};
in
	pkgs.callPackage ./parser.nix { inherit pkgs parserLang version src commonCmakeFlags; }
