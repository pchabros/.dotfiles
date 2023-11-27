{
  description = "System configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    nix-colors.url = "github:misterio77/nix-colors";
    # Neovim
    mini-indentscope = {
      url = "github:echasnovski/mini.indentscope";
      flake = false;
    };
    # indent-blankline-nvim = {
    #   url = "github:lukas-reineke/indent-blankline.nvim";
    #   flake = false;
    # };
    mini-bufremove = {
      url = "github:echasnovski/mini.bufremove";
      flake = false;
    };
    none-ls = {
      url = "github:nvimtools/none-ls.nvim";
      flake = false;
    };
    git-conflict = {
      url = "github:akinsho/git-conflict.nvim";
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
  };

  outputs = { nixpkgs, home-manager, hyprland, ... }@inputs:
    let
      system = "x86_64-linux";
      username = "pawel_chabros";
      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
      };
      lib = nixpkgs.lib;
    in
    {
      nixosConfigurations.nixos = lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          ./system/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.${username}.imports = [
              ./users/${username}/home.nix
            ];
          }
          hyprland.nixosModules.default
          { programs.hyprland.enable = true; }
        ];

      };
    };
}
