-- ============================================================
-- ALPHA — startup dashboard
-- ============================================================

return {
  "goolord/alpha-nvim",
  event        = "VimEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local alpha     = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    -- ── Header ───────────────────────────────────────────────
    dashboard.section.header.val = {
      "                                                          ",
      "  ██╗  ██╗ █████╗ ██╗   ██╗███╗   ███╗██╗   ██╗██████╗ ██╗",
      "  ██║ ██╔╝██╔══██╗██║   ██║████╗ ████║██║   ██║██╔══██╗██║",
      "  █████╔╝ ███████║██║   ██║██╔████╔██║██║   ██║██║  ██║██║",
      "  ██╔═██╗ ██╔══██║██║   ██║██║╚██╔╝██║██║   ██║██║  ██║██║",
      "  ██║  ██╗██║  ██║╚██████╔╝██║ ╚═╝ ██║╚██████╔╝██████╔╝██║",
      "  ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚═╝     ╚═╝ ╚═════╝ ╚═════╝ ╚═╝",
      "              कौमुदी — moonlight for your editor              ",
      "                                                          ",
    }

    -- ── Menu ─────────────────────────────────────────────────
    dashboard.section.buttons.val = {
      dashboard.button("e",     "  New File",                       "<cmd>ene<cr>"),
      dashboard.button("SPC e", "  File Explorer",                  "<cmd>NvimTreeToggle<cr>"),
      dashboard.button("SPC ff","󰱼  Find File",                     "<cmd>Telescope find_files<cr>"),
      dashboard.button("SPC fw","  Find Word",                      "<cmd>Telescope live_grep<cr>"),
      dashboard.button("SPC fr","  Recent Files",                   "<cmd>Telescope oldfiles<cr>"),
      dashboard.button("SPC tt","  Theme Picker",                   "<cmd>lua require('core.themepicker').pick()<cr>"),
      dashboard.button("SPC wr","󰁯  Restore Session",               "<cmd>SessionRestore<cr>"),
      dashboard.button("l",     "󰒲  Open Lazy",                     "<cmd>Lazy<cr>"),
      dashboard.button("q",     "  Quit",                           "<cmd>qa<cr>"),
    }

    -- ── Footer — show plugin count ────────────────────────────
    local function footer()
      local stats  = require("lazy").stats()
      local loaded = stats.loaded
      local total  = stats.count
      return "⚡ " .. loaded .. " / " .. total .. " plugins loaded"
    end

    dashboard.section.footer.val = footer()
    dashboard.section.footer.opts.hl = "Keyword"
    dashboard.section.header.opts.hl = "Include"
    dashboard.section.buttons.opts.hl = "Function"

    alpha.setup(dashboard.opts)

    -- Disable folding on alpha buffer
    vim.api.nvim_create_autocmd("FileType", {
      pattern  = "alpha",
      callback = function()
        vim.opt_local.foldenable = false
        vim.opt_local.number     = false
        vim.opt_local.relativenumber = false
      end,
    })
  end,
}
