return {
  {
    "bluz71/vim-nightfly-colors",
    name = "nightfly",
    lazy = false,
    priority = 1000,
    config = function()
      -- vim.cmd([[colorscheme nightfly]])
      -- Lua initialization file
    end,
  },
  {
    "EdenEast/nightfox.nvim",
    name = "nightfox",
    lazy = false,
    priority = 1000,
    config = function()
      -- vim.cmd([[colorscheme tokyonight-night]])
      -- Default options
      require('nightfox').setup({
        options = {
          -- Compiled file's destination location
          compile_path = vim.fn.stdpath("cache") .. "/nightfox",
          compile_file_suffix = "_compiled", -- Compiled file suffix
          transparent = true,                -- Disable setting background
          terminal_colors = true,            -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
          dim_inactive = false,              -- Non focused panes set to alternative background
          module_default = true,             -- Default enable value for modules
          colorblind = {
            enable = false,                  -- Enable colorblind support
            simulate_only = false,           -- Only show simulated colorblind colors and not diff shifted
            severity = {
              protan = 0,                    -- Severity [0,1] for protan (red)
              deutan = 0,                    -- Severity [0,1] for deutan (green)
              tritan = 0,                    -- Severity [0,1] for tritan (blue)
            },
          },
          styles = {           -- Style to be applied to different syntax groups
            comments = "NONE", -- Value is any valid attr-list value `:help attr-list`
            conditionals = "NONE",
            constants = "NONE",
            functions = "NONE",
            keywords = "NONE",
            numbers = "NONE",
            operators = "NONE",
            strings = "NONE",
            types = "NONE",
            variables = "NONE",
          },
          inverse = { -- Inverse highlight for different types
            match_paren = false,
            visual = false,
            search = false,
          },
          modules = { -- List of various plugins and additional options
            -- ...
          },
        },
        palettes = {},
        specs = {},
        groups = {},
      })

      -- setup must be called before loading
    end
  },

  {
    "folke/tokyonight.nvim",
    lazy     = false,
    priority = 1000,
    config   = function()
      -- vim.cmd([[colorscheme tokyonight-night]])
      require("tokyonight").setup {
        transparent = true,
        style = "night",
        styles = {
          sidebars = "transparent",
          floats = "transparent",
        }
      }
    end
  }
  ,
  -- lua/plugins/rose-pine.lua
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 1000,
    config = function()
      require("rose-pine").setup({
        variant = "moon",
        dark_variant = "main",
        dim_inactive_windows = false,
        extend_background_behind_borders = true,

        enable = {
          terminal = true,
          legacy_highlights = true,
          migrations = true,
        },

        styles = {
          bold = true,
          italic = true,
          transparency = true,
        },

        groups = {
          border = "muted",
          link = "iris",
          panel = "surface",

          error = "love",
          hint = "iris",
          info = "foam",
          note = "pine",
          todo = "rose",
          warn = "gold",

          git_add = "foam",
          git_change = "rose",
          git_delete = "love",
          git_dirty = "rose",
          git_ignore = "muted",
          git_merge = "iris",
          git_rename = "pine",
          git_stage = "iris",
          git_text = "rose",
          git_untracked = "subtle",

          h1 = "iris",
          h2 = "foam",
          h3 = "rose",
          h4 = "gold",
          h5 = "pine",
          h6 = "foam",
        },
      })

      vim.cmd("colorscheme rose-pine")

      -- Additional transparency fixes
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "rose-pine",
        callback = function()
          -- Basic transparency groups
          local transparent_groups = {
            "Normal", "NormalFloat", "CursorLine", "CursorColumn",
            "SignColumn", "FoldColumn", "LineNr", "CursorLineNr",
            "Pmenu", "PmenuSbar", "PmenuThumb", "StatusLine",
            "StatusLineNC", "TabLine", "TabLineSel", "TabLineFill",
            "WinSeparator", "VertSplit", "ColorColumn", "EndOfBuffer",
            "NvimTreeNormal", "NvimTreeEndOfBuffer", "NvimTreeCursorLine",
            "TelescopeNormal", "TelescopeBorder", "TelescopePromptNormal"
          }

          for _, group in ipairs(transparent_groups) do
            vim.api.nvim_set_hl(0, group, { bg = "none" })
          end

          -- Keep some selection backgrounds visible but slightly transparent
          vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#2a273f" })
          vim.api.nvim_set_hl(0, "Visual", { bg = "#2a273f" })

          -- Tree-sitter specific groups - make all transparent
          local treesitter_groups = {
            "@comment", "@keyword", "@function", "@method", "@variable",
            "@string", "@number", "@boolean", "@type", "@property",
            "@parameter", "@field", "@constructor", "@conditional",
            "@repeat", "@operator", "@exception", "@include", "@label",
            "@namespace", "@punctuation", "@tag", "@text", "@strong",
            "@emphasis", "@underline", "@literal", "@title", "@note"
          }

          for _, group in ipairs(treesitter_groups) do
            local existing_hl = vim.api.nvim_get_hl(0, { name = group })
            existing_hl.bg = "none"
            vim.api.nvim_set_hl(0, group, existing_hl)
          end
        end
      })

      -- Force apply transparency after colorscheme loads
      vim.cmd([[autocmd VimEnter * ++once lua vim.cmd('doautocmd ColorScheme rose-pine')]])
    end
  }
}
