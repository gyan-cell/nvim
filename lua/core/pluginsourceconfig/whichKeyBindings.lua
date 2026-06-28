-- ============================================================
-- WHICH-KEY v3 — keybinding popup + group labels
-- <leader>? to browse all keybindings
-- ============================================================

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    -- v3 API — timeout is now handled by vim.opt.timeoutlen in options.lua
    preset = "modern",  -- clean modern look
    delay  = 500,
    icons = {
      mappings = true,
      keys = {
        Up    = " ", Down  = " ",
        Left  = " ", Right = " ",
        C     = "󰘴 ", M    = "󰘵 ",
        D     = "󰘳 ", S    = "󰘶 ",
        CR    = "󰌑 ", Esc  = "󱊷 ",
        Tab   = "󰌒 ", Space = "󱁐 ",
        BS    = "󰁮 ",
      },
    },
    spec = {
      -- Group labels — these appear in the which-key popup
      { "<leader>f",  group = "Find / Telescope",    icon = "" },
      { "<leader>b",  group = "Buffer",              icon = "󰈔" },
      { "<leader>e",  group = "Explorer",            icon = "" },
      { "<leader>s",  group = "Splits",              icon = "" },
      { "<leader>w",  group = "Session",             icon = "󰆓" },
      { "<leader>t",  group = "Theme",               icon = "" },
      { "<leader>l",  group = "LSP / Diagnostics",   icon = "" },
      { "<leader>h",  group = "Harpoon",             icon = "󱡅" },
      { "<leader>d",  group = "Diagnostics",         icon = "" },
      { "<leader>sp", group = "Swap param →",        icon = "⇄" },
      { "<leader>sP", group = "Swap param ←",        icon = "⇄" },
      { "g",          group = "Go to",               icon = "" },
      { "]",          group = "Next",                icon = "→" },
      { "[",          group = "Prev",                icon = "←" },
    },
    win = {
      border   = "rounded",
      padding  = { 1, 2 },
      wo = { winblend = 5 },
    },
    layout = {
      width  = { min = 20 },
      spacing = 3,
    },
    show_help = true,
    show_keys = true,
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    -- <leader>? opens the full keybinding browser
    vim.keymap.set("n", "<leader>?", function() wk.show({ global = true }) end,
        { desc = "Show all keybindings" })
  end,
}
