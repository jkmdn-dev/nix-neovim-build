{ pkgs ? import <nixpkgs> {}, commonCmakeFlags ? [
		"-DBUILD_SHARED_LIBS=OFF"
 		"-DCMAKE_POSITION_INDEPENDENT_CODE=ON"
	] }:	
let
	inherit (pkgs) stdenv lib callPackage;
	inherit (lib) concatMapStringsSep concatStrings; 
	parsers = map (parserMod: ( callPackage parserMod { inherit pkgs commonCmakeFlags; } )) [
		./bash.nix
		./c.nix
		./lua.nix
		./markdown.nix
		./python.nix
		./query.nix
		./vim.nix
		./vimdoc.nix
	];
	makeSymLink = dep: "ln -s ${dep} $out/${dep.pname}";
	installScript = concatMapStringsSep "\n" makeSymLink parsers; 
in
	stdenv.mkDerivation {
		pname = "treesitter-parsers";
		version = "0.0.1";
		src = ./.;

		phases = [ "installPhase" ];

		buildInputs = parsers;

		installPhase = concatStrings [
			"mkdir $out \n"
			installScript
		];
}
