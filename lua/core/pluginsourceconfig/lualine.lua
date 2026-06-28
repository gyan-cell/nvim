-- ============================================================
-- LUALINE — status bar
-- ============================================================

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local function lsp_name()
      local clients = vim.lsp.get_clients({ bufnr = 0 })
      if #clients == 0 then return "" end
      local names = {}
      for _, c in ipairs(clients) do
        table.insert(names, c.name)
      end
      return "  " .. table.concat(names, ", ")
    end

    require("lualine").setup({
      options = {
        icons_enabled    = true,
        theme            = "auto",
        -- Slick powerline separators
        component_separators = { left = "", right = "" },
        section_separators   = { left = "", right = "" },
        disabled_filetypes   = {
          statusline = { "alpha", "dashboard" },
          winbar     = {},
        },
        ignore_focus     = {},
        always_divide_middle = true,
        -- Must be true when laststatus=3 (global statusline)
        globalstatus     = true,
        refresh = {
          statusline = 100,  -- refresh frequently for lsp info
          tabline    = 1000,
          winbar     = 1000,
        },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { { "filename", path = 1 } },  -- path=1 shows relative path
        lualine_x = { lsp_name, "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline    = {},
      winbar     = {},
      inactive_winbar = {},
      extensions = { "nvim-tree", "toggleterm", "lazy" },
    })
  end,
}
