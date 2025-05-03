# ~/dotfiles/flake.nix
{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11"; # Or a specific release branch

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs"; # Use the same nixpkgs
    };

    # gauntlet = {
    #   url = github:project-gauntlet/gauntlet/v18;
    #   inputs.nixpkgs.follows = "nixpkgs"; # Use the same nixpkgs
    # };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;

        config = {
          allowUnfree = true;
        };
      };
    in {
      homeConfigurations = {
        isaac = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home.nix ];
        };
      };
    };
}
