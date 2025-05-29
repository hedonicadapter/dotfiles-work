{
  description = "Nix-darwin config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    neovim-flake.url = "github:hedonicadapter/neovim-config-flake";
    colors-flake.url = "github:hedonicadapter/colors-flake";

    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:danth/stylix";

    mac-app-util.url = "github:hraban/mac-app-util";

    # zen-browser.url = "github:0xc000022070/zen-browser-flake";
    # zen-browser.inputs.nixpkgs.follows = "nixpkgs";

    spicetify-nix.url = "github:Gerg-L/spicetify-nix/24.11";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nix-darwin,
    colors-flake,
    ...
  }: let
    system = "aarch64-darwin";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [];
    };
    # colors-flake.colors = builtins.fromJSON (builtins.readFile ./stuff/colors.json);
  in {
    darwinConfigurations."default" = nix-darwin.lib.darwinSystem {
      inherit system;
      modules = with inputs; [
        stylix.darwinModules.stylix
        mac-app-util.darwinModules.default
        (import ./configuration.nix {
          inherit pkgs system;
          inherit (inputs) neovim-flake colors-flake;
        })
        home-manager.darwinModules.home-manager
        {
          home-manager.sharedModules = [
            mac-app-util.homeManagerModules.default
            spicetify-nix.homeManagerModules.spicetify
          ];
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.samherman1 = {
            imports = [./home.nix];
          };

          home-manager.extraSpecialArgs = {
            inherit system pkgs colors-flake spicetify-nix;
          };
        }
      ];
    };
  };
}
