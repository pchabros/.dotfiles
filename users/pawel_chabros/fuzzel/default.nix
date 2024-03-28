{ config, pkgs, ... }:
let
  appLauncher = pkgs.writeShellScriptBin "app-launcher" ''
    pkill fuzzel
    fuzzel
  '';
  dmenu = pkgs.writeShellScriptBin "dmenu" ''
    pkill fuzzel
    fuzzel -d $@
  '';
  emoji = pkgs.writeShellScriptBin "emoji" ''
    pkill fuzzel
    rofimoji --selector fuzzel --action $1
  '';
  clipboard = pkgs.writeShellScriptBin "clipboard-picker" ''
    pkill fuzzel
    cliphist list | dmenu | cliphist decode | wl-copy
  '';
  colors = config.colorScheme.palette;
  transparency = {
    _95 = "E6";
    _100 = "FF";
  };
in {
  home.packages = [ appLauncher dmenu emoji clipboard ];
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        output = "HDMI-A-1";
        font = "JetBrainsMono Nerd Font:pixelsize=14,monospace:pixelsize=14";
        prompt = "󰄾 ";
        exit-on-keyboard-focus-loss = "no";
        horizontal-pad = 100;
        vertical-pad = 40;
        inner-pad = 30;
        line-height = 18;
        icons-enabled = false;
      };
      colors = {
        background = "${colors.base00}${transparency._95}";
        text = "${colors.base06}${transparency._100}";
        match = "${colors.base06}${transparency._100}";
        selection = "${colors.base00}${transparency._95}";
        selection-text = "${colors.base0C}${transparency._100}";
        selection-match = "${colors.base0E}${transparency._100}";
      };
      border = {
        width = 0;
        radius = 6;
      };
    };
  };
}
