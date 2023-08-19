{ config, pkgs, ... }: {
  imports = [
    ./alacritty
    ./git
    ./hyprland
    ./neovim
    ./rofi
    ./tmux
    ./wallpaper
    ./zsh
  ];
  home = {
    username = "pawel_chabros";
    homeDirectory = "/home/pawel_chabros";
    stateVersion = "22.11";
  };
  programs = {
    home-manager.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
