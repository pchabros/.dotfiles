{ config, pkgs, ... }: {
  imports = [
    ./alacritty
    ./git
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
  services = {
    polybar = {
      enable = true;
      script = ''
        PATH=$PATH:${pkgs.i3}/bin polybar example &
      '';
      package = pkgs.polybar.override {
        alsaSupport = true;
        pulseSupport = true;
        i3GapsSupport = true;
      };
    };
    #avizo.enable = true;
  };
  xdg.configFile = {
    "i3/config".text = builtins.readFile ../../config/i3/config;
    rofi = {
      source = ../../config/rofi;
      recursive = true;
    };
    "polybar/config.ini".text = builtins.readFile ../../config/polybar/config.ini;
  };
}
