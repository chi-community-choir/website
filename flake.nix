{
  description = "chi comm choir dev environment";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/bfa9810ff7104a17555ab68ebdeafb6705f129b1";

  outputs = { self, nixpkgs }: {
    devShells.x86_64-linux.default =
      let pkgs = nixpkgs.legacyPackages."x86_64-linux";
      in pkgs.mkShell {
          buildInputs = with pkgs; [
            tmux
            git
            gleam
            erlang_27
            rebar3
            bun
          ];
        };
  };
}
