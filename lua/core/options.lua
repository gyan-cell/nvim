-- ============================================================
-- OPTIONS
-- ============================================================

-- Set leader keys early (must be set before any plugins load)
vim.g.mapleader      = " "
vim.g.maplocalleader = " "

-- True color support (must be early)
vim.opt.termguicolors = true

-- ── Indentation ──────────────────────────────────────────────
vim.opt.tabstop     = 2          -- a tab = 2 columns
vim.opt.shiftwidth  = 2          -- auto-indent step
vim.opt.softtabstop = 2          -- backspace removes 2 spaces
vim.opt.expandtab   = true       -- spaces, not tabs
vim.opt.shiftround  = true       -- round indent to shiftwidth

-- ── UI ───────────────────────────────────────────────────────
vim.opt.number         = true    -- absolute line numbers
vim.opt.relativenumber = true    -- relative line numbers
vim.opt.signcolumn     = "yes"   -- always show sign column (no layout jump)
vim.opt.cursorline     = true    -- highlight current line
vim.opt.wrap           = false   -- no line wrapping
vim.opt.textwidth      = 0       -- no forced hard breaks
vim.opt.scrolloff      = 8       -- keep 8 lines above/below cursor
vim.opt.sidescrolloff  = 8       -- keep 8 columns left/right
vim.opt.showmode       = false   -- lualine shows the mode
vim.opt.laststatus     = 3       -- global statusline (one bar for all windows)
vim.opt.cmdheight      = 1
vim.opt.guicursor      = "n-v-c-sm-i-ci-ve:block,r-cr-o:hor20" -- Block in Normal/Insert/Visual/Cmdline, Underline in Replace!


-- Window separator — transparent so themes control it
vim.api.nvim_set_hl(0, "WinSeparator", { bg = "None" })

-- ── Editing ──────────────────────────────────────────────────
vim.opt.cindent        = true
vim.opt.backspace      = "indent,eol,start"
vim.opt.clipboard      = "unnamedplus"  -- share with OS clipboard
vim.opt.conceallevel   = 2              -- hide markdown syntax chars
vim.opt.list           = false
vim.opt.listchars      = "trail:·,nbsp:◇,tab:→ ,extends:▸,precedes:◂"

-- ── Search ───────────────────────────────────────────────────
vim.opt.ignorecase = true   -- case insensitive…
vim.opt.smartcase  = true   -- …unless uppercase present
vim.opt.hlsearch   = true

-- ── Files / Undo ─────────────────────────────────────────────
vim.opt.autowrite  = true   -- save before :make / buffer switch
vim.opt.autoread   = true   -- reload if changed outside nvim
vim.opt.backup     = false
vim.opt.writebackup= false
vim.opt.swapfile   = false
vim.opt.undofile   = true
vim.opt.undodir    = vim.fn.stdpath("data") .. "/undo"

-- ── Timing ───────────────────────────────────────────────────
vim.opt.updatetime = 50    -- faster CursorHold / gitsigns
vim.opt.timeoutlen = 500   -- which-key popup delay

-- ── Sessions ─────────────────────────────────────────────────
vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- ── Splits ───────────────────────────────────────────────────
vim.opt.splitright = true  -- vertical splits go right
vim.opt.splitbelow = true  -- horizontal splits go below
vim.opt.splitkeep  = "cursor"  -- keep cursor position when splitting (nvim 0.9+)

-- ── History & Tags ───────────────────────────────────────────
vim.opt.history = 1000
vim.opt.tags    = ".tags"

-- ── Mouse ────────────────────────────────────────────────────
vim.opt.mouse = "a"

-- ── GUI Fonts (Neovide / GUI clients) ────────────────────────
if vim.fn.has("macunix") == 1 then
  vim.opt.guifont = "FiraCode Nerd Font:h17:l"
elseif vim.fn.has("linux") == 1 then
  vim.opt.guifont = "FiraCode Nerd Font:h11"
end

-- ── Neovide specific ─────────────────────────────────────────
if vim.g.neovide then
  vim.g.neovide_scroll_animation_length = 0.05
  vim.g.neovide_cursor_animation_length = 0.05
  vim.g.neovide_cursor_trail_size = 0.5
end

-- ── Transparency helper (called after colorscheme loads) ──────
vim.api.nvim_set_hl(0, "Normal",      { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
