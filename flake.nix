{
  description = "Food documentation development environment";
  inputs.nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

  outputs =
    { nixpkgs, ... }:
    {
      devShells = nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-darwin" ] (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.mkShell {
            packages = with pkgs; [
              nixfmt-rfc-style
              just
              python3
            ];
            shellHook = ''
              if [ ! -d .venv ]; then
                python -m venv .venv
              fi
              source .venv/bin/activate
              pip install --quiet zensical
            '';
          };
        }
      );
    };
}
