require "nvchad.options"

-- Statusline is rendered in tmux via vim-tpipeline when inside a session.
if vim.env.TMUX then
  vim.o.laststatus = 0
  vim.o.showmode = false
end

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
