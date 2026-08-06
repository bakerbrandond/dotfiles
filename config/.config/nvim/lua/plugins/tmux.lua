-- lua/plugins/tmux.lua
return {
  "christoomey/vim-tmux-navigator",
  lazy = false,
  init = function()
    -- mappings.lua sets keys after NvChad overrides them
    vim.g.tmux_navigator_no_mappings = 1
  end,
}
