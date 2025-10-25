{
  description = "Elixir Starter";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      nixpkgs,
      flake-utils,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };

        inherit (pkgs) inotify-tools terminal-notifier;
        inherit (pkgs.lib) optionals;
        inherit (pkgs.stdenv) isDarwin isLinux;

        linuxDeps = optionals isLinux [ inotify-tools ];
        darwinDeps = optionals isDarwin [ terminal-notifier ];
      in
      {
        devShells = {
          default = pkgs.mkShell {
            packages =
              with pkgs;
              [
                beam.packages.erlang_28.elixir_1_19
              ]
              ++ linuxDeps
              ++ darwinDeps;
            shellHook = ''
              mkdir -p .nix-mix .nix-hex
              export MIX_HOME=$PWD/.nix-mix
              export HEX_HOME=$PWD/.nix-hex
              export MIX_PATH="${pkgs.beam.packages.erlang_27.hex}/lib/erlang/lib/hex/ebin"
              export PATH=$MIX_HOME/bin:$HEX_HOME/bin:$PATH
              export LANG=C.UTF-8
              # keep your shell history in iex
              export ERL_AFLAGS="-kernel shell_history enabled"

              export MIX_ENV=dev
            '';
          };
        };
      }
    );
}
