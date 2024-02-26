{
  programs.starship.enable = true;
  xdg.configFile = {
    "starship.toml".text = builtins.readFile ./config/starship.toml;
  };
}
