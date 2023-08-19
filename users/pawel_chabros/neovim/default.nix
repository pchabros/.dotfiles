{ config, pkgs, ... }: {
  programs = {
    neovim = {
      enable = true;
      plugins = with pkgs.vimPlugins; [
        vim-nix
        nvim-treesitter.withAllGrammars
      ];
      extraConfig = ''
        luafile ~/.config/nvim/init.lua
      '';
      extraPackages = with pkgs; [
        fd
        gcc
        ripgrep
        xclip
        nodejs
        nodePackages.eslint_d
        nodePackages.typescript
        nodePackages.typescript-language-server
        rnix-lsp
        rust-analyzer
        sumneko-lua-language-server
      ];
    };
  };
  xdg.configFile = {
    nvim = {
      source = ./config;
      recursive = true;
    };
  };
}
