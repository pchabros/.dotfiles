{ config, pkgs, ... }: {
  imports = [
    ./alacritty
    ./git
    ./i3
    ./neovim
    ./tmux
    ./zsh
  ];
  home = {
    username = "kris";
    homeDirectory = "/home/kris";
    stateVersion = "22.11";
  };
  programs = {
    home-manager.enable = true;
    rofi = {
      enable = true;
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
  xdg.configFile = {
    rofi = {
      source = ../../config/rofi;
      recursive = true;
    };
  };
}
