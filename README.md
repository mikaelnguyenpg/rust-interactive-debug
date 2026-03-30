# How To Debug Rust Interactive Mode in VSCode due to Different Setup Variants

## Setup Environment

### Flake Variant

**Usage**:

- Init env `nix flake init` > `flake.nix`
- Add rust + rust-src + lldb to `flake.nix`
- Activate env:
  - AUTO each time access directory:
    - add `.envrc`
    - `direnv allow`
  - manual: `nix develop`
- Init project `cargo init`
- Start dev `code .`

```nix
<!-- flake.nix -->
{
  description = "Rust dev env";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in
  {
    devShells.default = pkgs.mkShell {
      buildInputs = with pkgs; [
        cargo
        rustc
        rust-src
        rust-analyzer
        lldb
      ];
    };
  };
}
```

```envrc
<!-- .envrc -->
use flake
```

### Mise Variant

**Usage**:

- (Optional) Enable `mise.toml`: `mise trust`
- Init env & Add rust & activate `mise use rust`
- (Optional) Install env `mise install`
- (Optional) Verify env activated: `mise current`
- Add lldb `sudo apt install lldb` (for CodeLLDB to Debug)
- Init project `cargo init`
- Start dev `code .`

### Devbox Variant

**Usage**:

- Init env `devbox init`
- Add rust + rust-src + lldb `devbox add cargo rustc rust-src rust-analyzer lldb`
- Activate env `devbox shell`
- Init project `cargo init`
- Start dev `code .`

## VSCode Usage

- Install extension: `CodeLLDB`
- Setup Debugger: `Ctrl + Shift + p` > `Debug: Add Configuration..` > `Code LLDB: Cargo ...` (`launch.json`)
- Start Debugging: `F5`

!IMPORTANT:

- MUST use `Code LLDB: Cargo ...` to generate correct Debug config
- Prerequisites:
  - VSCode: Install CodeLLDB
  - System: Install lldb
  - Rustup: Add rust-src

```json
// launch.json
{
  // Use IntelliSense to learn about possible attributes.
  // Hover to view descriptions of existing attributes.
  // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Debug executable 'flake-variant'",
      "type": "lldb",
      "request": "launch",
      "cargo": {
        "args": ["run", "--bin=flake-variant"]
      },
      "args": [],

      // (Optional)
      // When project is symlink
      "sourceMap": {
        "/data/20_Workspace/10_Active/rust-interactive-debug/flake-variant": "${workspaceFolder}"
      },
      "sourceLanguages": ["rust"],
      "program": "${workspaceFolder}/target/debug/PROJECT_NAME",
      "cwd": "${workspaceFolder}"
    }
  ]
}
```
