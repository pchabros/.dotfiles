{
  description = "System configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      type = "git";
      url = "https://github.com/hyprwm/Hyprland";
      submodules = true;
    };
    xremap.url = "github:xremap/nix-flake";
    nix-colors.url = "github:misterio77/nix-colors";
    tmux-sessionx.url = "github:omerxx/tmux-sessionx";
    # Neovim
    mini-indentscope = {
      url = "github:echasnovski/mini.indentscope";
      flake = false;
    };
    indent-blankline-nvim = {
      url = "github:lukas-reineke/indent-blankline.nvim";
      flake = false;
    };
    mini-bufremove = {
      url = "github:echasnovski/mini.bufremove";
      flake = false;
    };
    flash = {
      url = "github:folke/flash.nvim";
      flake = false;
    };
    cutlass = {
      url = "github:gbprod/cutlass.nvim";
      flake = false;
    };
    telescope-tabs = {
      url = "github:LukasPietzschmann/telescope-tabs";
      flake = false;
    };
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      username = "pawel_chabros";
      lib = nixpkgs.lib;
      sessionx = inputs.tmux-sessionx.packages.${system}.default;

      configs = {
        nixos = {
          main-monitor = "HDMI-A-1";
          side-monitor = "DP-1";
          version = "23.05";
        };
        solaris = {
          main-monitor = "DP-1";
          side-monitor = "HDMI-A-1";
          version = "23.11";
        };
      };
      buildNixOS = hostname:
        { main-monitor, side-monitor, version }:
        let is-laptop = hostname == "nixos";
        in lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs hostname version; };
          modules = [
            inputs.xremap.nixosModules.default
            ./system/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.extraSpecialArgs = {
                inherit inputs username sessionx is-laptop main-monitor
                  side-monitor;
              };
              home-manager.users.${username}.imports =
                [ ./users/${username}/home.nix ];
            }
          ];
        };
    in {
      nixosConfigurations = lib.mapAttrs buildNixOS configs;

    };
}
