{ config, pkgs, ... }: {
  xdg.configFile = {
    "i3/config".text = builtins.readFile ./config/config;
  };
}
