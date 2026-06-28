-- ============================================================
-- NVIM-TREE — file explorer (ultra-snappy & beautiful edition)
-- ============================================================

return {
  "nvim-tree/nvim-tree.lua",
  lazy         = false,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- Disable netrw (nvim-tree takes over)
    vim.g.loaded_netrw       = 1
    vim.g.loaded_netrwPlugin = 1

    require("nvim-tree").setup({
      -- ── Performance & Snappiness ─────────────────────────────
      update_focused_file = {
        enable     = true,
        update_cwd = true,
        debounce_delay = 15, -- Super snappy refresh when changing buffers
      },
      filesystem_watchers = {
        enable = true, -- Snappy automatic file system updates via libuv
        debounce_delay = 50,
      },

      -- ── File visibility ──────────────────────────────────────
      filters = {
        dotfiles  = false, -- show dotfiles (.env, .gitignore, etc.) by default
        git_clean = false,
        no_buffer = false,
        custom    = { "^\\.git$" }, -- hide only the .git folder
        exclude   = {},
      },

      -- ── Git integration (Optimized) ───────────────────────────
      git = {
        enable  = true,
        ignore  = true, -- hide git-ignored files by default for performance; toggle with `gi`
        timeout = 200,  -- low timeout to avoid blockages
      },

      -- ── Renderer (Gorgeous minimalist styling) ─────────────────
      renderer = {
        add_trailing        = false, -- cleaner visual layout without trailing /
        group_empty         = true,  -- collapse empty nested directories
        highlight_git       = true,
        highlight_opened_files = "name",
        root_folder_label   = ":~:s?$?/..?", -- relative path root
        indent_markers = {
          enable = true,
          inline_arrows = true,
          icons = {
            corner = "└",
            edge = "│",
            item = "│",
            bottom = "─",
            none = " ",
          },
        },
        icons = {
          show = {
            file        = true,
            folder      = true,
            folder_arrow = false, -- cleaner borderless layout
            git         = true,
          },
          glyphs = {
            default  = "󰈚",
            symlink  = "",
            bookmark = "󰆤",
            modified = "●",
            folder = {
              arrow_open   = "",
              arrow_closed = "",
              default      = "󰉋",
              open         = "󰉓",
              empty        = "󱞞",
              empty_open   = "󱞞",
              symlink      = "",
              symlink_open = "",
            },
            git = {
              unstaged  = "󰔧",
              staged    = "󰗡",
              unmerged  = "",
              renamed   = "➜",
              untracked = "󰛔",
              deleted   = "",
              ignored   = "◌",
            },
          },
        },
      },

      -- ── Diagnostics (Disabled for maximum snappiness) ────────
      -- (Diagnostic checks on sidebar folders are heavily laggy on big projects)
      diagnostics = {
        enable       = false,
      },

      -- ── View (Clean flat side panel) ──────────────────────────
      view = {
        width            = 30,
        side             = "left",
        preserve_window_proportions = true,
        number           = false,
        relativenumber   = false,
        signcolumn       = "no", -- gorgeous flat layout without the clunky left signcolumn!
      },

      -- ── Actions ───────────────────────────────────────────────
      actions = {
        open_file = {
          quit_on_open  = false,
          resize_window = true,
          window_picker = {
            enable = true,
          },
        },
      },

      -- ── Keymaps ──────────────────────────────────────────────
      on_attach = function(bufnr)
        local api = require("nvim-tree.api")
        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end
        -- Load defaults
        api.config.mappings.default_on_attach(bufnr)
        -- Toggle hidden files with H
        vim.keymap.set("n", "<leader>H", api.tree.toggle_hidden_filter, opts("Toggle hidden files"))
        -- Toggle git-ignored files with gi
        vim.keymap.set("n", "gi",        api.tree.toggle_gitignore_filter, opts("Toggle git ignored"))
      end,
    })
  end,
}
