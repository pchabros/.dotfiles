{ pkgs, ... }: {
  programs = {
    tmux = {
      enable = true;
      terminal = "xterm-256color";
      plugins = with pkgs.tmuxPlugins; [ copycat extrakto resurrect tmux-fzf ];
    };
  };
  xdg.configFile = {
    "tmux/tmux.conf".text = builtins.readFile ./config/tmux.conf;
    "tms/default-config.toml".text = builtins.readFile ./config/tms.toml;
  };
}
