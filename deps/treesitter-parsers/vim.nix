{ pkgs ? import <nixpkgs> {}, commonCmakeFlags ? [
		"-DBUILD_SHARED_LIBS=OFF"
 		"-DCMAKE_POSITION_INDEPENDENT_CODE=ON"
	] }:
let                 
	parserLang = "vim";
	version = "0.3.0";
	src = {
		url = "https://github.com/neovim/tree-sitter-vim/archive/v0.3.0.tar.gz";
		sha256 = "403acec3efb7cdb18ff3d68640fc823502a4ffcdfbb71cec3f98aa786c21cbe2";
	};
in
	pkgs.callPackage ./parser.nix { inherit pkgs parserLang version src commonCmakeFlags; }
