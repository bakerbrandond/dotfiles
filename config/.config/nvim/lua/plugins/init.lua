return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- required for format_on_save in configs/conform.lua
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  {
    -- Parsers to install. nvchad's spec runs `:TSUpdate | TSInstallAll` as its
    -- build step, and its TSInstallAll reads this list off the merged spec, so
    -- a fresh machine gets these automatically. On a machine where the plugin
    -- is already installed, run :TSInstallAll (or :Lazy build nvim-treesitter).
    --
    -- Requires the tree-sitter CLI -- the treesitter main branch shells out to
    -- it to compile parsers, and a missing CLI is why this list can appear to
    -- do nothing. It is `tree-sitter-cli` in the Brewfiles; brew's
    -- `tree-sitter` formula ships only the library.
    --
    -- This list replaces nvchad's default rather than extending it, so its
    -- defaults are repeated here.
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        -- nvchad defaults
        "lua",
        "luadoc",
        "printf",
        "vim",
        "vimdoc",
        -- ours
        "bash",
        "css",
        "dockerfile",
        "git_config",
        "gitcommit",
        "go",
        "gomod",
        "gosum",
        "html",
        "javascript",
        "json",
        "jsonc",
        "make",
        "markdown",
        "markdown_inline",
        "python",
        "toml",
        "tsx",
        "typescript",
        "yaml",
      },
    },
  },
}
