-- ============================================================
-- COLORS — Multiple themes + active theme set here
-- ============================================================
-- To switch themes interactively use <leader>tt (theme picker)
-- ============================================================

return {
  -- ── Rose Pine (active default) ──────────────────────────────
  {
    "rose-pine/neovim",
    name     = "rose-pine",
    lazy     = false,
    priority = 1000,
    config   = function()
      require("rose-pine").setup({
        variant      = "moon",
        dark_variant = "main",
        dim_inactive_windows = false,
        extend_background_behind_borders = true,
        enable = {
          terminal        = true,
          legacy_highlights = true,
          migrations      = true,
        },
        styles = {
          bold         = true,
          italic       = true,
          transparency = true,
        },
        groups = {
          border = "muted", link = "iris", panel = "surface",
          error = "love",  hint = "iris", info = "foam",
          note  = "pine",  todo = "rose", warn = "gold",
          git_add      = "foam",  git_change   = "rose",
          git_delete   = "love",  git_dirty    = "rose",
          git_ignore   = "muted", git_merge    = "iris",
          git_rename   = "pine",  git_stage    = "iris",
          git_text     = "rose",  git_untracked = "subtle",
          h1 = "iris", h2 = "foam", h3 = "rose",
          h4 = "gold", h5 = "pine", h6 = "foam",
        },
      })

      vim.cmd("colorscheme rose-pine")

      -- Transparency patches applied after colorscheme loads
      local function apply_transparency()
        local transparent = {
          "Normal", "NormalFloat", "NormalNC",
          "CursorLine", "CursorColumn", "SignColumn", "FoldColumn",
          "LineNr", "CursorLineNr", "Pmenu", "PmenuSbar", "PmenuThumb",
          "StatusLine", "StatusLineNC", "TabLine", "TabLineSel", "TabLineFill",
          "WinSeparator", "VertSplit", "ColorColumn", "EndOfBuffer",
          "NvimTreeNormal", "NvimTreeEndOfBuffer", "NvimTreeCursorLine",
          "TelescopeNormal", "TelescopeBorder", "TelescopePromptNormal",
          "WhichKeyFloat",
        }
        for _, group in ipairs(transparent) do
          vim.api.nvim_set_hl(0, group, { bg = "none" })
        end
        -- Keep subtle selection highlights visible
        vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#2a273f" })
        vim.api.nvim_set_hl(0, "Visual",   { bg = "#2a273f" })

        -- Preserve fg on treesitter groups, clear their bg only
        local ts_groups = {
          "@comment", "@keyword", "@function", "@method", "@variable",
          "@string", "@number", "@boolean", "@type", "@property",
          "@parameter", "@field", "@constructor", "@conditional",
          "@repeat", "@operator", "@exception", "@include", "@label",
          "@namespace", "@punctuation", "@tag", "@text", "@strong",
          "@emphasis", "@underline", "@literal", "@title",
        }
        for _, group in ipairs(ts_groups) do
          local hl = vim.api.nvim_get_hl(0, { name = group })
          hl.bg = nil
          vim.api.nvim_set_hl(0, group, hl)
        end
      end

      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern  = "*",
        callback = apply_transparency,
      })
      -- Apply once immediately for the initial load
      vim.schedule(apply_transparency)
    end,
  },

  -- ── Tokyo Night ──────────────────────────────────────────────
  {
    "folke/tokyonight.nvim",
    lazy     = true,
    priority = 900,
    opts = {
      transparent = true,
      style       = "night",
      styles      = { sidebars = "transparent", floats = "transparent" },
    },
  },

  -- ── Catppuccin ───────────────────────────────────────────────
  {
    "catppuccin/nvim",
    name     = "catppuccin",
    lazy     = true,
    priority = 900,
    opts = {
      flavour          = "mocha",
      transparent_background = true,
      integrations = {
        nvimtree   = true,
        telescope  = { enabled = true },
        treesitter = true,
        which_key  = true,
        harpoon    = true,
        gitsigns   = true,
        barbar     = true,
        mason      = true,
        lsp_trouble = true,
      },
    },
  },

  -- ── Kanagawa ─────────────────────────────────────────────────
  {
    "rebelot/kanagawa.nvim",
    lazy     = true,
    priority = 900,
    opts = {
      transparent = true,
      theme       = "wave",
      background  = { dark = "wave", light = "lotus" },
      overrides = function(colors)
        return {
          -- Absolute transparent floating windows
          NormalFloat = { bg = "none" },
          FloatBorder = { bg = "none" },
          FloatTitle  = { bg = "none" },
          
          -- Transparent panels
          LazyNormal  = { bg = "none" },
          MasonNormal = { bg = "none" },
          
          -- Transparent popups/menus
          Pmenu       = { bg = "none" },
          PmenuSbar   = { bg = "none" },
          PmenuThumb  = { bg = "none" },
          
          -- Transparent Telescope panels
          TelescopeNormal = { bg = "none" },
          TelescopeBorder = { bg = "none" },
        }
      end,
    },
  },

  -- ── Gruvbox Material ─────────────────────────────────────────
  {
    "sainnhe/gruvbox-material",
    lazy     = true,
    priority = 900,
    config = function()
      vim.g.gruvbox_material_background        = "hard"
      vim.g.gruvbox_material_transparent_background = 1
      vim.g.gruvbox_material_better_performance = 1
    end,
  },

  -- ── Oxocarbon ────────────────────────────────────────────────
  {
    "nyoom-engineering/oxocarbon.nvim",
    lazy     = true,
    priority = 900,
  },
}
