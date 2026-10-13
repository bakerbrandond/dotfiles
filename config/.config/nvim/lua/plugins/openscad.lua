return {
  {
    -- Syntax, cheatsheet (<CR>), fuzzy help (<A-h>), PDF manual (<A-m>),
    -- open in OpenSCAD (<A-o>) and LuaSnip snippets for .scad files.
    -- Run :checkhealth openscad to verify.
    "salkin-mada/openscad.nvim",
    ft = "openscad",
    dependencies = {
      -- The help picker supports only fzf-lua or snacks, not telescope.
      "ibhagwan/fzf-lua",
      "L3MON4D3/LuaSnip", -- already pulled in by nvchad
    },
    init = function()
      vim.g.openscad_default_mappings = true
      vim.g.openscad_load_snippets = true
      vim.g.openscad_pdf_cmd = "xdg-open"
    end,
    config = function()
      require "openscad"
    end,
  },
}
