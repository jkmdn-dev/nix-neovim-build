{ pkgs ? import <nixpkgs> {} }:
let
  inherit (pkgs)
    stdenv
    fetchFromGitHub
    cmake
    ninja
    callPackage
    gettext
    autoPatchelfHook
    lib
    ;

  deps = callPackage ./deps { inherit pkgs; };
in
stdenv.mkDerivation {
  name = "nix-neovim-build";
  version = "0.10.0-dev";

  src = fetchFromGitHub {
    owner = "neovim";
    repo = "neovim";
    rev = "5d4e1693cb415e8b76749e833e28f00f14630b87";
    sha256 = "sha256-dCwN7Z4t+pmGuH90Dff5h1qIm2Rh917cZX3GF/W5GYk=";
  };

  nativeBuildInputs = [
    cmake
    ninja
    autoPatchelfHook
  ];

  buildInputs = [ gettext deps ];

  preConfigure =
    ''
      export PATH=${deps}/luajit/bin:$PATH
      export PATH=${deps}/luajit/lib:${deps}/luajit/include:$PATH
      export PATH=${deps}/luv/lib:${deps}/luv/include:$PATH
      export PATH=${deps}/libuv/lib:${deps}/libuv/include:$PATH
      export PATH=${deps}/libvterm/lib:${deps}/libvterm/include:$PATH
      export PATH=${deps}/lpeg/lib:$PATH
      export PATH=${deps}/msgpack/lib:${deps}/msgpack/include:$PATH
      export PATH=${deps}/treesitter/lib:${deps}/treesitter/include:$PATH
      export PATH=${deps}/unibilium/lib:${deps}/unibilium/include:$PATH
    '';

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
    "-DDEPS_PREFIX=${deps}"
  ];

  postInstall =
    ''
      addAutoPatchelfSearchPath ${deps}/luajit/lib/
    '';

  meta = with lib; {
    homepage = https://neovim.io;
    description = "Neovim built with Nix";
    license = licenses.asl20;
    platforms = platforms.linux;
    maintainers = [ "joakimpaulsson" ];
  };
}
