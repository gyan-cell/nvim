-- ============================================================
-- TELESCOPE — fuzzy finder
-- ============================================================

return {
  "nvim-telescope/telescope.nvim",
  -- Not pinning to 0.1.x branch anymore — latest stable via lazy
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local telescope = require("telescope")
    local actions   = require("telescope.actions")

    telescope.setup({
      defaults = {
        path_display = { "truncate" },
        -- Show hidden files (dotfiles) in results
        file_ignore_patterns = { "%.git/", "node_modules/", "%.cache/" },
        hidden = true,
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            ["<C-x>"] = actions.delete_buffer,
          },
          n = {
            ["q"] = actions.close,
          },
        },
        layout_config = {
          horizontal = { preview_width = 0.55 },
          vertical   = { mirror = false },
          width      = 0.85,
          height     = 0.85,
        },
        sorting_strategy = "ascending",
        layout_strategy  = "horizontal",
        border           = true,
        borderchars      = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      },
      pickers = {
        find_files = {
          hidden     = true,   -- show dotfiles
          no_ignore  = false,  -- still respect .gitignore
        },
        live_grep = {
          additional_args = { "--hidden" },
        },
      },
    })

    telescope.load_extension("fzf")

    -- Register the theme picker keymap here (after telescope is ready)
    vim.keymap.set("n", "<leader>tt", function()
      require("core.themepicker").pick()
    end, { desc = "Theme picker" })

    -- ── Keymaps ───────────────────────────────────────────────
    local map = vim.keymap.set

    map("n", "<leader>ff", "<cmd>Telescope find_files<cr>",                  { desc = "Find files" })
    map("n", "<leader>fw", "<cmd>Telescope live_grep<cr>",                   { desc = "Find word (grep)" })
    map("n", "<leader>fc", "<cmd>Telescope grep_string<cr>",                 { desc = "Find word under cursor" })
    map("n", "<leader>fb", "<cmd>Telescope buffers<cr>",                     { desc = "Find open buffers" })
    map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>",                   { desc = "Find help" })
    map("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>",                    { desc = "Find recent files" })
    map("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>",                 { desc = "Find diagnostics" })
    map("n", "<leader>fk", "<cmd>Telescope keymaps<cr>",                     { desc = "Find keymaps" })
    map("n", "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>",        { desc = "Find document symbols" })
    map("n", "<leader>f.", "<cmd>Telescope find_files hidden=true no_ignore=true<cr>", { desc = "Find all files (including ignored)" })
  end,
}
