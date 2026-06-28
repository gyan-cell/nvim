-- ============================================================
-- MAPPINGS
-- ============================================================


local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ── File Explorer ─────────────────────────────────────────────
map("n", "<leader>e",  "<cmd>NvimTreeToggle<cr>",   { desc = "Toggle file tree" })
map("n", "<leader>ef", "<cmd>NvimTreeFindFile<cr>", { desc = "Reveal file in tree" })

-- ── Window Splits ─────────────────────────────────────────────
map("n", "<leader>sv", "<cmd>vsplit<cr>", { desc = "Split vertical" })
map("n", "<leader>sh", "<cmd>split<cr>",  { desc = "Split horizontal" })
map("n", "<leader>se", "<C-w>=",          { desc = "Equalise splits" })
map("n", "<leader>sx", "<cmd>close<cr>",  { desc = "Close current split" })

-- ── Window Navigation (Ctrl + arrow directions) ───────────────
-- NOTE: h/l are remapped to l/h intentionally to match your existing layout
map("n", "<C-h>", "<C-w>l", opts)   -- right
map("n", "<C-l>", "<C-w>h", opts)   -- left
map("n", "<C-t>", "<C-w>k", opts)   -- up
map("n", "<C-d>", "<C-w>j", opts)   -- down

-- ── Window Resize ─────────────────────────────────────────────
map("n", "<C-Up>",    "<cmd>resize +2<cr>",          { desc = "Resize up" })
map("n", "<C-Down>",  "<cmd>resize -2<cr>",          { desc = "Resize down" })
map("n", "<C-Left>",  "<cmd>vertical resize -2<cr>", { desc = "Resize left" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Resize right" })

-- ── Buffer Navigation (barbar) ────────────────────────────────
map("n", "<A-,>", "<cmd>BufferPrevious<cr>",        { desc = "Prev buffer" })
map("n", "<A-.>", "<cmd>BufferNext<cr>",            { desc = "Next buffer" })
map("n", "<A-<>", "<cmd>BufferMovePrevious<cr>",    { desc = "Move buffer left" })
map("n", "<A->>", "<cmd>BufferMoveNext<cr>",        { desc = "Move buffer right" })
map("n", "<A-1>", "<cmd>BufferGoto 1<cr>",          { desc = "Buffer 1" })
map("n", "<A-2>", "<cmd>BufferGoto 2<cr>",          { desc = "Buffer 2" })
map("n", "<A-3>", "<cmd>BufferGoto 3<cr>",          { desc = "Buffer 3" })
map("n", "<A-4>", "<cmd>BufferGoto 4<cr>",          { desc = "Buffer 4" })
map("n", "<A-5>", "<cmd>BufferGoto 5<cr>",          { desc = "Buffer 5" })
map("n", "<A-6>", "<cmd>BufferGoto 6<cr>",          { desc = "Buffer 6" })
map("n", "<A-7>", "<cmd>BufferGoto 7<cr>",          { desc = "Buffer 7" })
map("n", "<A-8>", "<cmd>BufferGoto 8<cr>",          { desc = "Buffer 8" })
map("n", "<A-9>", "<cmd>BufferGoto 9<cr>",          { desc = "Buffer 9" })
map("n", "<A-0>", "<cmd>BufferLast<cr>",            { desc = "Last buffer" })
map("n", "<A-p>", "<cmd>BufferPin<cr>",             { desc = "Pin/unpin buffer" })
map("n", "<A-c>", "<cmd>BufferClose<cr>",           { desc = "Close buffer" })
map("n", "<C-p>", "<cmd>BufferPick<cr>",            { desc = "Pick buffer" })

-- Easy leader-prefixed buffer mappings
map("n", "<leader>bp", "<cmd>BufferPrevious<cr>",     { desc = "Prev buffer" })
map("n", "<leader>bn", "<cmd>BufferNext<cr>",         { desc = "Next buffer" })
map("n", "<leader>bc", "<cmd>BufferClose<cr>",        { desc = "Close buffer" })
map("n", "<leader>bj", "<cmd>BufferPick<cr>",         { desc = "Pick buffer" })
map("n", "<leader>bx", "<cmd>BufferClose<cr>",        { desc = "Close buffer" })

-- Buffer sort
map("n", "<leader>bb", "<cmd>BufferOrderByBufferNumber<cr>", { desc = "Sort by number" })
map("n", "<leader>bd", "<cmd>BufferOrderByDirectory<cr>",    { desc = "Sort by dir" })
map("n", "<leader>bl", "<cmd>BufferOrderByLanguage<cr>",     { desc = "Sort by lang" })
map("n", "<leader>bw", "<cmd>BufferOrderByWindowNumber<cr>", { desc = "Sort by window" })

-- ── Editing Quality of Life ───────────────────────────────────
-- Clear search highlight on Esc
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })

-- Stay in indent mode after indent
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- Move lines up/down in visual mode
map("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<cr>gv=gv", { desc = "Move selection up" })

-- Keep cursor centered when jumping / searching
map("n", "n",     "nzzzv", opts)
map("n", "N",     "Nzzzv", opts)
map("n", "<C-d>", "<C-d>zz", opts)  -- note: also used as window nav above; zz centers after jump
map("n", "<C-u>", "<C-u>zz", opts)

-- Delete without yanking to clipboard
map({ "n", "v" }, "<leader>D", [["_d]], { desc = "Delete (no yank)" })

-- ── Diagnostics ───────────────────────────────────────────────
-- NOTE: Full diagnostic config (signs, virtual_text, etc.) is in lspconfig.lua
-- This only overrides float options for the diagnostic keymaps below
vim.diagnostic.config({
  float = {
    border = "rounded",
    source = true,
  },
})

map("n", "<leader>d",  vim.diagnostic.open_float,                           { desc = "Show diagnostic float" })
map("n", "<leader>p",  function() vim.diagnostic.jump({ count = -1 }) end,  { desc = "Prev diagnostic" })
map("n", "<leader>n",  function() vim.diagnostic.jump({ count = 1 }) end,   { desc = "Next diagnostic" })
map("n", "<leader>l",  vim.diagnostic.setloclist,                           { desc = "Diagnostics to loclist" })

-- Easy leader-prefixed diagnostics mappings
map("n", "<leader>dd", vim.diagnostic.open_float,                           { desc = "Show diagnostic float" })
map("n", "<leader>dp", function() vim.diagnostic.jump({ count = -1 }) end,  { desc = "Prev diagnostic" })
map("n", "<leader>dn", function() vim.diagnostic.jump({ count = 1 }) end,   { desc = "Next diagnostic" })
map("n", "<leader>dl", vim.diagnostic.setloclist,                           { desc = "Diagnostics to loclist" })

-- ── Misc ──────────────────────────────────────────────────────
-- Save shortcut
map({ "n", "i", "v" }, "<C-s>", "<Esc><cmd>w<cr>", { desc = "Save file" })

-- Keybinding overview
map("n", "<leader>?",  "<cmd>WhichKey<cr>",          { desc = "Show all keybindings (WhichKey)" })
map("n", "<leader>lk", "<cmd>Telescope keymaps<cr>", { desc = "List all keybindings (Telescope)" })
map("n", "<F1>",       "<cmd>Telescope keymaps<cr>", { desc = "List all keybindings (Telescope)" })

