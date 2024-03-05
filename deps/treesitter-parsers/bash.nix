{ pkgs ? import <nixpkgs> {}, commonCmakeFlags ? [
		"-DBUILD_SHARED_LIBS=OFF"
 		"-DCMAKE_POSITION_INDEPENDENT_CODE=ON"
	] }:
let                 
	parserLang = "bash";
	version = "0.20.5";
	src = {
		url = "https://github.com/tree-sitter/tree-sitter-bash/archive/v0.20.5.tar.gz";
		sha256 = "7bba80ac64a18ec1b3f47e738e6a168f065c3cb4244234eff1b773816008f5a7";
	};
in
	pkgs.callPackage ./parser.nix { inherit pkgs parserLang version src commonCmakeFlags; }

