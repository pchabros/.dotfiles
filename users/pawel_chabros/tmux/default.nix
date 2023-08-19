{ config, pkgs, ... }: {
  programs = {
    tmux = {
      enable = true;
      terminal = "xterm-256color";
      plugins = with pkgs.tmuxPlugins; [
        copycat
        extrakto
        nord
        resurrect
        tmux-fzf
      ];
    };
  };
  xdg.configFile = {
    "tmux/tmux.conf".text = builtins.readFile ./config/tmux.conf;
  };
}
