{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      nvim-cmp
      nvim-lspconfig
      nvim-treesitter.withAllGrammars
      nvim-web-devicons
      telescope-nvim
      plenary-nvim
      nvim-ts-autotag
      nord-nvim
      undotree
      which-key-nvim
      vim-tmux-navigator
      lazygit-nvim
      lsp-zero-nvim
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp_luasnip
      luasnip
      friendly-snippets
      nvim-autopairs
      # git-conflict
      trouble-nvim
      # flash
      # cutlass
      bufferline-nvim
      lualine-nvim
      comment-nvim
      neodev-nvim
      # none-ls
      dressing-nvim
      indent-blankline-nvim
      # mini-indentscope
      noice-nvim
      nui-nvim
      nvim-notify
      neo-tree-nvim
      nvim-spectre




      vim-nix
      neodev-nvim
    ];
    extraPackages = with pkgs; [
      rnix-lsp
      sumneko-lua-language-server
    ];
    extraLuaConfig = ''
      ${builtins.readFile ./config/init.lua}
    '';
  };
}
