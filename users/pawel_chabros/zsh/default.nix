{ pkgs, ... }: {
  programs = {
    zsh = {
      enable = true;
      initExtra = builtins.readFile ./config/.zshrc;
      dotDir = ".config/zsh";
      enableAutosuggestions = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
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
        save = 100000;
        size = 100000;
      };
      prezto = {
        enable = true;
        editor = {
          keymap = "vi";
          promptContext = true;
          dotExpansion = true;
        };
      };
      plugins = [{
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.8.0";
          sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
        };
      }];
      zplug = {
        enable = true;
        plugins = [
          {
            name = "plugins/git";
            tags = [ "from:oh-my-zsh" ];
          }
          {
            name = "plugins/completion";
            tags = [ "from:oh-my-zsh" ];
          }
          {
            name = "plugins/tmux";
            tags = [ "from:oh-my-zsh" ];
          }
          { name = "stedolan/jq"; }
        ];
      };
    };
    eza = {
      enable = true;
      enableAliases = true;
      git = true;
      icons = true;
    };
    zoxide.enable = true;
  };
  xdg.configFile = { "zsh/aliases".text = builtins.readFile ./config/aliases; };
}
