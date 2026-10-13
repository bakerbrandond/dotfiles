return {
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      -- Nord aurora + frost accents (https://www.nordtheme.com/docs/colors-and-palettes)
      local nord = {
        frost1 = "#88C0D0", -- nord8
        frost2 = "#81A1C1", -- nord9
        frost3 = "#5E81AC", -- nord10
        aqua   = "#8FBCBB", -- nord7
        red    = "#BF616A", -- nord11
        orange = "#D08770", -- nord12
        yellow = "#EBCB8B", -- nord13
        green  = "#A3BE8C", -- nord14
        purple = "#B48EAD", -- nord15
      }

      local highlights = {
        RainbowDelimiterBlue   = { fg = nord.frost1 },
        RainbowDelimiterGreen  = { fg = nord.green },
        RainbowDelimiterYellow = { fg = nord.yellow },
        RainbowDelimiterOrange = { fg = nord.orange },
        RainbowDelimiterViolet = { fg = nord.purple },
        RainbowDelimiterCyan   = { fg = nord.aqua },
        RainbowDelimiterRed    = { fg = nord.frost2 },
      }

      local function set_highlights()
        for group, spec in pairs(highlights) do
          vim.api.nvim_set_hl(0, group, spec)
        end
      end

      set_highlights()
      vim.api.nvim_create_autocmd("ColorScheme", { callback = set_highlights })

      require("rainbow-delimiters.setup").setup({
        -- On nvim 0.12 get_parser returns nil instead of throwing, so the
        -- plugin's own guard misses and it errors on every filetype with no
        -- parser (openscad, tcl, ...). Returning nil skips the buffer.
        strategy = {
          [""] = function(bufnr)
            if vim.treesitter.get_parser(bufnr, nil, { error = false }) then
              return require("rainbow-delimiters").strategy["global"]
            end
          end,
        },
        highlight = {
          "RainbowDelimiterBlue",
          "RainbowDelimiterGreen",
          "RainbowDelimiterYellow",
          "RainbowDelimiterOrange",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
          "RainbowDelimiterRed",
        },
      })
    end,
  },
}
