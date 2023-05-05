{ config, pkgs, ... }: {
  home = {
    username = "kris";
    homeDirectory = "/home/kris";
    stateVersion = "22.11";
  };
  programs = {
    home-manager.enable = true;
    git = {
      enable = true;
      userName  = "pchabros";
      userEmail = "pawel.chabros@yahoo.pl";
    };
    neovim = {
      enable = true;
      extraConfig = ''
        luafile ~/.config/nvim/init.lua
      '';
      extraPackages = with pkgs; [
        fd
        gcc
        ripgrep
        xclip
      ];
    };
    alacritty = {
      enable = true;
    };
    rofi = {
      enable = true;
    };
    tmux = rec {
      enable = true;
      plugins = with pkgs.tmuxPlugins; [
        copycat
        extrakto
        nord
        resurrect
        tmux-fzf
      ];
      extraConfig = "${pkgs.lib.concatStrings (map (x: "run-shell ${x.rtp}\n") plugins)}";
    };
  };
  xdg.configFile = {
    nvim = {
      source = ../../config/nvim;
      recursive = true;
    };
    tmux = {
      source = ../../config/tmux;
    };
    alacritty = {
      source = ../../config/alacritty;
    };
    i3 = {
      source = ../../config/i3;
      recursive = true;
    };
  };
}
