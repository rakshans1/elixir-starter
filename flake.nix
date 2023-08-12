{
  description = "Elixir Starter";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };

        inherit (pkgs) darwin inotify-tools terminal-notifier;
        inherit (pkgs.lib) optional;
        inherit (pkgs.stdenv) isDarwin isLinux;

        linuxDeps = optional isLinux [ inotify-tools ];
        darwinDeps = optional isDarwin [ terminal-notifier ]
          ++ (with darwin.apple_sdk.frameworks; [
          CoreFoundation
          CoreServices
        ]);

      in
      {
        devShells = {
          default = pkgs.mkShell {
            packages = with pkgs;  [
              beam.packages.erlangR26.elixir_1_15
            ] ++ linuxDeps ++ darwinDeps;
            shellHook = ''
              # this allows mix to work on the local directory
              mkdir -p .nix-mix .nix-hex
              export MIX_HOME=$PWD/.nix-mix
              export HEX_HOME=$PWD/.nix-hex
              # make hex from Nixpkgs available
              # `mix local.hex` will install hex into MIX_HOME and should take precedence
              export MIX_PATH="${pkgs.beam.packages.erlangR26.hex}/lib/erlang/lib/hex/ebin"
              export PATH=$MIX_HOME/bin:$HEX_HOME/bin:$PATH
              export LANG=C.UTF-8
              # keep your shell history in iex
              export ERL_AFLAGS="-kernel shell_history enabled"

              export MIX_ENV=dev
            '';
          };
        };
      });
}
