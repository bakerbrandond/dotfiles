require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

-- NvChad maps <C-h/j/k/l> to vim splits only; restore tmux-aware navigation.
map("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", { desc = "Navigate left" })
map("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>", { desc = "Navigate down" })
map("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>", { desc = "Navigate up" })
map("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>", { desc = "Navigate right" })
map("n", "<C-\\>", "<cmd>TmuxNavigatePrevious<cr>", { desc = "Navigate previous" })

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
