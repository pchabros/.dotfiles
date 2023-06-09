{ config, pkgs, ... }: {
  programs = {
    zsh = {
      enable = true;
      initExtra = builtins.readFile ./config/zsh/.zshrc;
      dotDir = ".config/zsh";
      enableAutosuggestions = true;
      enableCompletion = true;
      enableSyntaxHighlighting = true;
      autocd = true;
      sessionVariables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
        TERM = "xterm-256color";
        FZF_DEFAULT_COMMAND = "rg --files --hidden --glob '!.git'";
        FZF_CTRL_T_COMMAND = "$FZF_DEFAULT_COMMAND";
        ZSH_TMUX_AUTOSTART = true;
        ZSH_TMUX_CONFIG = "$HOME/.config/tmux/tmux.conf";
      };
      history = {
        ignoreDups = true;
        save = 1000000;
        size = 1000000;
      };
      prezto = {
        enable = true;
        editor = {
          keymap = "vi";
          promptContext = true;
          dotExpansion = true;
        };
        prompt.theme = "pure";
      };
      zplug = {
        enable = true;
        plugins = [
          { name = "plugins/git"; tags = [ from:oh-my-zsh ]; }
          { name = "plugins/completion"; tags = [ from:oh-my-zsh ]; }
          { name = "plugins/tmux"; tags = [ from:oh-my-zsh ]; }
          { name = "stedolan/jq"; }
        ];
      };
    };
  };
  xdg.configFile = {
    "zsh/aliases".text = builtins.readFile ./config/zsh/aliases;
  };
}
