-- This config is an attempt to mimic the <selection>-<action> behavior in Helix

local map = vim.keymap.set
local del = vim.keymap.del

-- `w`, `W`, `e`, `E`, `b`, `B`: will move the cursor and select
map("n", "w", "<esc>viw", { noremap = true, silent = true })
map("n", "W", "<esc>viW", { noremap = true, silent = true })
map("n", "e", "<esc>ve", { noremap = true, silent = true })
map("n", "E", "<esc>vE", { noremap = true, silent = true })
map("n", "b", "<esc>vb", { noremap = true, silent = true })
map("n", "B", "<esc>vB", { noremap = true, silent = true })
map("v", "w", "<esc>w", { noremap = true, silent = true })
map("v", "W", "<esc>W", { noremap = true, silent = true })
map("v", "e", "<esc>e", { noremap = true, silent = true })
map("v", "E", "<esc>E", { noremap = true, silent = true })
map("v", "b", "<esc>b", { noremap = true, silent = true })
map("v", "B", "<esc>B", { noremap = true, silent = true })

-- `x`, `X` to select entire line
map("n", "x", "V", { noremap = true, silent = true })
map("v", "x", "j", { noremap = true, silent = true })
map("n", "X", "V", { noremap = true, silent = true })
map("n", "d", "vd", { noremap = true, silent = true }) -- To supplement `x`
