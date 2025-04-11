-- Set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps -------------------

-- Use jk to exit insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- Clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- Delete single character without copying into register
keymap.set("n", "<leader>=", "<C-a>", { desc = "Increment number" })

-- Increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- Window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

keymap.set("n", "<C-z>", "u", { desc = "Undo", noremap = true, silent = true }) -- undo change

-- Move line down (like Shift + Alt + Down in VS Code)
keymap.set("n", "<leader>k", ":m .+1<CR>==", { desc = "Move line down", noremap = true, silent = true })

-- Move line up (like Shift + Alt + Up in VS Code)
keymap.set("n", "<leader>j", ":m .-2<CR>==", { desc = "Move line up", noremap = true, silent = true })

-- Also work in visual mode
keymap.set("v", "<leader>k", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down", noremap = true, silent = true })
keymap.set("v", "<leader>j", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up", noremap = true, silent = true })

-- Open iTerm in a new window with Ctrl + X
keymap.set("n", "<C-x>", ":!open -na iTerm<CR>", { noremap = true, silent = true, desc = "Open iTerm in new window" })

-- Close iTerm with Ctrl + Z (manually closing the window is still the best practice)
keymap.set("n", "<C-i>", ":!osascript -e 'tell application \"iTerm\" to quit'<CR>", { noremap = true, silent = true })

-- Keybinding to switch from terminal insert mode to normal mode (like pressing Esc)
keymap.set("t", "<leader>n", [[<C-\><C-n>]], { noremap = true, silent = true, desc = "Terminal to Normal mode" })
