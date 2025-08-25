{
  pkgs,
  inputs,
  ...
}: let
  vimPlugins =
    pkgs.vimPlugins
    // {
      mini-indentscope = pkgs.vimUtils.buildVimPlugin {
        name = "mini-indentscope";
        src = inputs.mini-indentscope;
      };
      mini-bufremove = pkgs.vimUtils.buildVimPlugin {
        name = "mini-bufremove";
        src = inputs.mini-bufremove;
      };
      cutlass = pkgs.vimUtils.buildVimPlugin {
        name = "cutlass";
        src = inputs.cutlass;
      };
      csvview = pkgs.vimUtils.buildVimPlugin {
        name = "csvview";
        src = inputs.csvview;
      };
    };
in {
  programs.neovim = {
    enable = true;
    vimdiffAlias = true;
    plugins = with vimPlugins; [
      cmp-buffer
      cmp-nvim-lsp
      cmp-path
      cmp_luasnip
      dressing-nvim
      git-conflict-nvim
      lazygit-nvim
      lens-vim
      lsp-zero-nvim
      luasnip
      markdown-preview-nvim
      nui-nvim
      # nvim-gdb
      nvim-nio
      nvim-notify
      nvim-web-devicons
      plenary-nvim
      vim-nix
      vim-tmux-navigator
      which-key-nvim
      tagalong-vim
      targets-vim
      haskell-tools-nvim
      rest-nvim
      {
        plugin = nvim-dap;
        type = "lua";
        config = ''
          ${builtins.readFile ./config/plugins/nvim-dap.lua}
        '';
      }
      nvim-dap-ui
      nvim-dap-python
      {
        plugin = nvim-dbee;
        type = "lua";
        config = ''
          require('dbee').setup()
        '';
      }
      {
        plugin = nvim-highlight-colors;
        type = "lua";
        config = ''
          require('nvim-highlight-colors').setup()
        '';
      }
      {
        plugin = nord-nvim;
        type = "lua";
        config = ''
          vim.cmd("colorscheme nord")
          vim.cmd("hi WinSeparator guifg=#373e4d")
        '';
      }
      {
        plugin = nvim-autopairs;
        type = "lua";
        config = ''
          require('nvim-autopairs').setup()
        '';
      }
      {
        plugin = comment-nvim;
        type = "lua";
        config = ''
          require("Comment").setup()
        '';
      }
      {
        plugin = neodev-nvim;
        type = "lua";
        config = ''
          require("neodev").setup({
            library = { plugins = { "neotest" }, types = true },
          })
        '';
      }
      {
        plugin = cutlass;
        type = "lua";
        config = ''
          require("cutlass").setup({ cut_key = "z" })
        '';
      }
      {
        plugin = todo-comments-nvim;
        type = "lua";
        config = ''
          require("todo-comments").setup()
        '';
      }
      {
        plugin = csvview;
        type = "lua";
        config = ''
          ${builtins.readFile ./config/plugins/csvview.lua}
        '';
      }
      {
        plugin = diffview-nvim;
        type = "lua";
        config = ''
          ${builtins.readFile ./config/plugins/diffview-nvim.lua}
        '';
      }
      {
        plugin = mini-nvim;
        type = "lua";
        config = ''
          ${builtins.readFile ./config/plugins/mini-nvim.lua}
        '';
      }
      {
        plugin = nvim-treesitter.withAllGrammars;
        type = "lua";
        config = ''
          ${builtins.readFile ./config/plugins/treesitter.lua}
        '';
      }
      {
        plugin = nvim-treesitter-textobjects;
        type = "lua";
        config = ''
          ${builtins.readFile ./config/plugins/nvim-treesitter-textobjects.lua}
        '';
      }
      {
        plugin = vim-bookmarks;
        type = "lua";
        config = ''
          ${builtins.readFile ./config/plugins/vim-bookmarks.lua}
        '';
      }
      telescope-vim-bookmarks-nvim
      {
        plugin = auto-session;
        type = "lua";
        config = ''
          ${builtins.readFile ./config/plugins/auto-session.lua}
        '';
      }
      {
        plugin = none-ls-nvim;
        type = "lua";
        config = ''
          ${builtins.readFile ./config/plugins/none-ls-nvim.lua}
        '';
      }
      {
        plugin = flash-nvim;
        type = "lua";
        config = ''
          ${builtins.readFile ./config/plugins/flash-nvim.lua}
        '';
      }
      {
        plugin = mini-bufremove;
        type = "lua";
        config = ''
          ${builtins.readFile ./config/plugins/mini-bufremove.lua}
        '';
      }
      {
        plugin = mini-indentscope;
        type = "lua";
        config = ''
          ${builtins.readFile ./config/plugins/mini-indentscope.lua}
        '';
      }
      {
        plugin = nvim-cmp;
        type = "lua";
        config = ''
          ${builtins.readFile ./config/plugins/nvim-cmp.lua}
        '';
      }
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = ''
          ${builtins.readFile ./config/plugins/nvim-lspconfig.lua}
        '';
      }
      {
        plugin = telescope-nvim;
        type = "lua";
        config = ''
          ${builtins.readFile ./config/plugins/telescope-nvim.lua}
        '';
      }
      {
        plugin = undotree;
        type = "lua";
        config = ''
          ${builtins.readFile ./config/plugins/undotree.lua}
        '';
      }
      {
        plugin = trouble-nvim;
        type = "lua";
        config = ''
          ${builtins.readFile ./config/plugins/trouble-nvim.lua}
        '';
      }
      {
        plugin = bufferline-nvim;
        type = "lua";
        config = ''
          ${builtins.readFile ./config/plugins/bufferline-nvim.lua}
        '';
      }
      {
        plugin = noice-nvim;
        type = "lua";
        config = ''
          ${builtins.readFile ./config/plugins/noice-nvim.lua}
        '';
      }
      {
        plugin = neo-tree-nvim;
        type = "lua";
        config = ''
          ${builtins.readFile ./config/plugins/neo-tree-nvim.lua}
        '';
      }
      {
        plugin = nvim-spectre;
        type = "lua";
        config = ''
          ${builtins.readFile ./config/plugins/nvim-spectre.lua}
        '';
      }
      {
        plugin = gitsigns-nvim;
        type = "lua";
        config = ''
          ${builtins.readFile ./config/plugins/gitsigns-nvim.lua}
        '';
      }
      {
        plugin = vim-illuminate;
        type = "lua";
        config = ''
          ${builtins.readFile ./config/plugins/vim-illuminate.lua}
        '';
      }
      {
        plugin = indent-blankline-nvim;
        type = "lua";
        config = ''
          ${builtins.readFile ./config/plugins/indent-blankline-nvim.lua}
        '';
      }
      {
        plugin = friendly-snippets;
        type = "lua";
        config = ''
          ${builtins.readFile ./config/plugins/friendly-snippets.lua}
        '';
      }
      {
        plugin = iron-nvim;
        type = "lua";
        config = ''
          ${builtins.readFile ./config/plugins/iron-nvim.lua}
        '';
      }
      {
        plugin = neotest;
        type = "lua";
        config = ''
          ${builtins.readFile ./config/plugins/neotest.lua}
        '';
      }
      {
        plugin = rustaceanvim;
        type = "lua";
        config = ''
          ${builtins.readFile ./config/plugins/rustaceanvim.lua}
        '';
      }
      neotest-jest
      neotest-python
      FixCursorHold-nvim
    ];
    extraPackages = with pkgs; [
      alejandra
      docker-compose-language-service
      dockerfile-language-server-nodejs
      emmet-ls
      luajitPackages.jsregexp
      nginx-config-formatter
      nginx-language-server
      nil
      nixfmt-rfc-style
      nodePackages_latest.bash-language-server
      nodePackages_latest.eslint_d
      nodePackages_latest.nodejs
      nodePackages_latest.prettier
      pyright
      python312Packages.python-lsp-server
      ripgrep
      ruff
      shellcheck
      shfmt
      statix
      stylua
      sumneko-lua-language-server
      tailwindcss-language-server
      vscode-langservers-extracted
      wl-clipboard
      yaml-language-server
    ];
    extraLuaConfig = ''
      ${builtins.readFile ./config/utils.lua}
      ${builtins.readFile ./config/autocmds.lua}
      ${builtins.readFile ./config/keymaps.lua}
      ${builtins.readFile ./config/options.lua}
      ${builtins.readFile ./config/plugins/git.lua}
    '';
  };
  xdg.configFile = {
    "nvim/after".source = ./config/after;
  };
}
