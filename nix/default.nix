{ sources ? import ./sources.nix
, pkgs ? import sources.nixpkgs { }
}:

with pkgs;

buildEnv {
  name = "builder";
  paths = [
    beam.packages.erlangR24.elixir_1_13
  ];
}
