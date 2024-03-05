{ pkgs ? import <nixpkgs> {} }:	

let
	inherit (pkgs) stdenv callPackage lib;
	inherit (lib) concatStrings concatMapStringsSep;
	commonCmakeFlags = [
		"-DBUILD_SHARED_LIBS=OFF"
 		"-DCMAKE_POSITION_INDEPENDENT_CODE=ON"
	];
	deps = map (dep: ( callPackage dep { inherit pkgs commonCmakeFlags; } )) [
		./libuv.nix
		./libvterm.nix
		./lpeg.nix
		./lua-compat53.nix
		./luajit.nix
		./lua.nix
		./luv.nix
		./msgpack.nix
		./treesitter.nix
		./treesitter-parsers
		./unibilium.nix
	];
	makeSymLink = dep: "ln -s ${dep} $out/${dep.pname}";
	installScript = concatMapStringsSep "\n" makeSymLink deps; 
in
	stdenv.mkDerivation {
		pname = "deps";
		version = "0.0.1";
		src = ./.;

		phases = [ "installPhase" ];

		buildInputs = deps;

		installPhase = concatStrings [
			"mkdir $out \n"
			installScript
		];
}
