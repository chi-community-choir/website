{ pkgs ? import (builtins.fetchGit {
      name = "nixos-unstable-2025-03-25";
      url = "https://github.com/NixOS/nixpkgs";
      ref = "refs/heads/nixos-unstable";
      rev = "bfa9810ff7104a17555ab68ebdeafb6705f129b1";
    }) {}
}:
pkgs.mkShell {
    buildInputs = with pkgs; [ tmux git gleam erlang_27 rebar3 bun ];
}
