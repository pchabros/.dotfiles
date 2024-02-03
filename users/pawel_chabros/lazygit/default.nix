{
  programs.lazygit.enable = true;
  home.file.".config/lazygit/config.yml".text =
    builtins.readFile ./config/config.yml;
}
