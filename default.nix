{ nixpkgs ? (import <nixpkgs> {}) }:
let
  inherit (nixpkgs) stdenv bash;
  version = "0.1.0";
in 
  nixpkgs.stdenv.mkDerivation {
    name = "nixy-${version}";
    src = ./.;

    installPhase = ''
      mkdir -p $out/bin;
      cp bin/nixy $out/bin;
    '';

    meta = {
      description = "Command-line interface to the Nix package manager";
      license = stdenv.lib.licenses.gpl3;
      platforms = stdenv.lib.platforms.all;
    };
  }
