# let
#   nixpkgs' = import <nixpkgs> {};
# in
#   {
#    nixpkgs ? import (nixpkgs'.fetchFromGithub { owner = "NixOS";
#                                                 repo  = "nixpkgs";
#                                                 rev = "master";}),
#    stdenv, fetchurl, bash, coreutils
#   }:

#   let
#     pkgs = if nixpkgs == null then nixpkgs' else nixpkgs;
#   in
#     pkgs.stdenv.mkDerivation {
#       name = "nixy";
#       src = ./.;
#       installPhase = ''
#         mkdir -p $out/bin
#         cp nixy $/out/bin
#       '';
#     }

{ nixpkgs ? (import <nixpkgs> {}) }:
let
  inherit (nixpkgs) stdenv bash;
in 
  nixpkgs.stdenv.mkDerivation {
    name = "nixy";
    src = ./.;
    installPhase = ''
      echo "\$bash is $bash"
    '';
  }
