{
  description = "NixOS modules for the atproto PDS";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
  };

  outputs = { self, nixpkgs }:
  let
    supportedSystems = [ "x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin" ];
    forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; overlays = [ self.overlay ]; });
  in
  {
    overlay = final: prev: {
      atproto-pds = with final; stdenv.mkDerivation {

      }; 
    };

    packages = forAllSystems (system: {
      inherit (nixpkgsFor.${system}) atproto-pds; 
    });

    nixosModules.default = { pkgs, ... }: {

    };
  };
}
