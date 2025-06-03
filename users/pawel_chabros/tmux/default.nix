{
  pkgs,
  sessionx,
  ...
}: {
  programs = {
    tmux = {
      enable = true;
      terminal = "xterm-256color";
      plugins = with pkgs.tmuxPlugins; [copycat extrakto sessionx resurrect];
    };
  };
  xdg.configFile = {
    "tmux/tmux.conf".text = builtins.readFile ./config/tmux.conf;
    "tms/default-config.toml".text = builtins.readFile ./config/tms.toml;
  };
}
