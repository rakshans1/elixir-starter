# Elixir Starter

## 🏗️ Prerequisites

- [nix](https://nix.dev/tutorials/install-nix)
- [direnv](https://direnv.net/docs/installation.html)

Setup direnv with [shell](https://direnv.net/docs/hook.html)

Run `direnv allow`

```
Elixir: 1.15.4
OTP:    26.0.2
```

`nix flake show https://github.com/rakshans1/elixir-starter`

```
github:rakshans1/elixir-starter/0acf13f351f2de2c44eb0690c9824f8ac3776ad1
└───devShells
    ├───aarch64-darwin
    │   └───default: development environment 'nix-shell'
    ├───aarch64-linux
    │   └───default: development environment 'nix-shell'
    ├───x86_64-darwin
    │   └───default: development environment 'nix-shell'
    └───x86_64-linux
        └───default: development environment 'nix-shell'
```
