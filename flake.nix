{
  description = "chi comm choir dev environment";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/c9f568d3f09178f499e454b1cad4eba5041b8259";

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
