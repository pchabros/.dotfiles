{ config, pkgs, ... }: {
  imports = [
    ./neovim
    ./alacritty
  ];
  home = {
    username = "kris";
    homeDirectory = "/home/kris";
    stateVersion = "22.11";
  };
  programs = {
    home-manager.enable = true;
    git = {
      enable = true;
      userName = "pchabros";
      userEmail = "pawel.chabros@yahoo.pl";
    };
    zsh = {
      enable = true;
      initExtra = builtins.readFile ../../config/zsh/.zshrc;
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
    rofi = {
      enable = true;
    };
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
    gh = {
      enable = true;
      extensions = with pkgs; [
        gh-dash
      ];
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
  services = {
    polybar = {
      enable = true;
      script = ''
        PATH=$PATH:${pkgs.i3}/bin polybar example &
      '';
      package = pkgs.polybar.override {
        alsaSupport = true;
        pulseSupport = true;
        i3GapsSupport = true;
      };
    };
    #avizo.enable = true;
  };
  xdg.configFile = {
    "zsh/aliases".text = builtins.readFile ../../config/zsh/aliases;
    "tmux/tmux.conf".text = builtins.readFile ../../config/tmux/tmux.conf;
    "i3/config".text = builtins.readFile ../../config/i3/config;
    rofi = {
      source = ../../config/rofi;
      recursive = true;
    };
    "polybar/config.ini".text = builtins.readFile ../../config/polybar/config.ini;
  };
}
