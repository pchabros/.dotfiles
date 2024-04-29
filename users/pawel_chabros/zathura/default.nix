{
  programs.zathura = {
    enable = true;
    extraConfig = builtins.readFile ./config/zathurarc;
  };
}
