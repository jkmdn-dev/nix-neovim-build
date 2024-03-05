{ pkgs ? import <nixpkgs> {}, commonCmakeFlags ? [
		"-DBUILD_SHARED_LIBS=OFF"
 		"-DCMAKE_POSITION_INDEPENDENT_CODE=ON"
	] }:
let                 
	parserLang = "markdown";
	version = "0.1.7";
	src = {
		url = "https://github.com/MDeiml/tree-sitter-markdown/archive/v0.1.7.tar.gz";
		sha256 = "7d0e7f7ed4516ed0816f9c304e2e7fa93b2c16f9280416c2fb64dc4efd9c5f83";
	};
	cmakeFile = ./cmake/MarkdownParserCMakeLists.txt;
in
	pkgs.callPackage ./parser.nix { inherit pkgs parserLang version src cmakeFile commonCmakeFlags; }
