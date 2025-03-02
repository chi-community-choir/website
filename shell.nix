{ pkgs ? import <nixpkgs> { } }:
pkgs.mkShell {
    buildInputs = with pkgs; [ tmux git gleam erlang_27 rebar3 ];
}
