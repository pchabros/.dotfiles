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
      none-ls-nvim
      nui-nvim
      nvim-notify
      nvim-treesitter.withAllGrammars
      nvim-ts-autotag
      nvim-web-devicons
      plenary-nvim
      vim-nix
      vim-tmux-navigator
      which-key-nvim
      {
        plugin = nord-nvim;
        type = "lua";
        config = ''
          vim.cmd("colorscheme nord")
        '';
      }
      {
        plugin = friendly-snippets;
        type = "lua";
        config = ''
          require("luasnip.loaders.from_vscode").lazy_load()
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
          require("neodev").setup()
        '';
      }
      {
        plugin = mini-nvim;
        type = "lua";
        config = ''
          require("mini.ai").setup()
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
        plugin = lualine-nvim;
        type = "lua";
        config = ''
          ${builtins.readFile ./config/plugins/lualine-nvim.lua}
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
    ];
    extraPackages = with pkgs; [
      nil
      nixfmt
      nodePackages_latest.eslint_d
      nodePackages_latest.nodejs
      nodePackages_latest.prettier
      nodePackages_latest.typescript
      nodePackages_latest.typescript-language-server
      prettierd
      ripgrep
      stylua
      sumneko-lua-language-server
      vscode-extensions.angular.ng-template
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
