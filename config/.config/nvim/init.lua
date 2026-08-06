vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- vim-tpipeline needs TMUX=/path/to/socket,session,pane. Always reconcile from tmux
-- (shell may export a broken TMUX=0 which breaks tpipeline and the tmux CLI).
if vim.fn.executable "tmux" == 1 then
  vim.env.TMUX = nil
  local socket = vim.fn.systemlist("env -u TMUX tmux display-message -p '#{socket_path}'")[1]
  local sid = vim.fn.systemlist("env -u TMUX tmux display-message -p '#{session_id}'")[1]
  if socket and sid and socket ~= "" and sid ~= "" then
    local num = sid:match "%$(%d+)" or sid:gsub("%$", "")
    vim.env.TMUX = socket .. "," .. sid .. "," .. num
  end
end

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "autocmds"

vim.schedule(function()
  require "mappings"
end)
