{ pkgs, inputs, ... }:
let
  vimPlugins = pkgs.vimPlugins // {
    git-conflict = pkgs.vimUtils.buildVimPlugin {
      name = "git-conflict";
      src = inputs.git-conflict;
    };
    mini-indentscope = pkgs.vimUtils.buildVimPlugin {
      name = "mini-indentscope";
      src = inputs.mini-indentscope;
    };
    indent-blankline-nvim = pkgs.vimUtils.buildVimPlugin {
      name = "indent-blankline-nvim";
      src = inputs.indent-blankline-nvim;
    };
    mini-bufremove = pkgs.vimUtils.buildVimPlugin {
      name = "mini-bufremove";
      src = inputs.mini-bufremove;
    };
    flash = pkgs.vimUtils.buildVimPlugin {
      name = "flash";
      src = inputs.flash;
    };
    cutlass = pkgs.vimUtils.buildVimPlugin {
      name = "cutlass";
      src = inputs.cutlass;
    };
    telescope-tabs = pkgs.vimUtils.buildVimPlugin {
      name = "telescope-tabs";
      src = inputs.telescope-tabs;
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
      git-conflict
      lazygit-nvim
      lens-vim
      lsp-zero-nvim
      luasnip
      nui-nvim
      nvim-notify
      nvim-ts-autotag
      nvim-web-devicons
      plenary-nvim
      vim-nix
      vim-tmux-navigator
      which-key-nvim
      {
        plugin = nvim-highlight-colors;
        type = "lua";
        config = ''
          require('nvim-highlight-colors').setup({})
        '';
      }
      {
        plugin = nord-nvim;
        type = "lua";
        config = ''
          vim.cmd("colorscheme nord")
        '';
      }
      {
        plugin = nvim-autopairs;
        type = "lua";
        config = ''
          require('nvim-autopairs').setup({})
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
        plugin = git-worktree-nvim;
        type = "lua";
        config = ''
          ${builtins.readFile ./config/plugins/git-worktree-nvim.lua}
        '';
      }
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
        plugin = flash;
        type = "lua";
        config = ''
          ${builtins.readFile ./config/plugins/flash.lua}
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
        plugin = telescope-tabs;
        type = "lua";
        config = ''
          ${builtins.readFile ./config/plugins/telescope-tabs.lua}
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
      neotest-jest
      neotest-python
      FixCursorHold-nvim
    ];
    extraPackages = with pkgs; [
      beautysh
      emmet-ls
      luajitPackages.jsregexp
      mypy
      nil
      nixfmt
      nodePackages_latest.eslint_d
      nodePackages_latest.nodejs
      nodePackages_latest.pyright
      nodePackages_latest.typescript
      nodePackages_latest.typescript-language-server
      python311Packages.python-lsp-server
      ripgrep
      rPackages.languageserver
      ruff
      ruff-lsp
      shellcheck
      stylua
      sumneko-lua-language-server
      tailwindcss-language-server
      vscode-langservers-extracted
      wl-clipboard
    ];
    extraLuaConfig = ''
      ${builtins.readFile ./config/utils.lua}
      ${builtins.readFile ./config/autocmds.lua}
      ${builtins.readFile ./config/keymaps.lua}
      ${builtins.readFile ./config/options.lua}
      ${builtins.readFile ./config/plugins/git.lua}
    '';
  };
}
