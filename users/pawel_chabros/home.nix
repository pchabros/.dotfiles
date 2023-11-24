{ config, pkgs, inputs, ... }: {
  imports = [
    inputs.nix-colors.homeManagerModules.default
    ./alacritty
    ./email
    ./firefox
    ./fuzzel
    ./fzf
    ./git
    ./gtk
    ./hyprland
    ./lazygit
    ./neovim
    ./starship
    ./tmux
    ./wallpaper
    ./zsh
  ];
  colorScheme = inputs.nix-colors.colorSchemes.nord;
  home = {
    username = "pawel_chabros";
    homeDirectory = "/home/pawel_chabros";
    stateVersion = "23.05";
  };
  programs = {
    home-manager.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
