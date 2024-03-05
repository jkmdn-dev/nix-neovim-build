{ pkgs ? import <nixpkgs> {}, commonCmakeFlags ? [
		"-DBUILD_SHARED_LIBS=OFF"
 		"-DCMAKE_POSITION_INDEPENDENT_CODE=ON"
	] }:
let                 
	parserLang = "c";
	version = "0.20.8";
	src = {
		url = "https://github.com/tree-sitter/tree-sitter-c/archive/v0.20.8.tar.gz";
		sha256 = "50f8aa6a84e2ad532cc3384e84e9f9f91fe3ec41c74f58e0c1e1013df5bf3a88";
	};
in
	pkgs.callPackage ./parser.nix { inherit pkgs parserLang version src commonCmakeFlags; }
