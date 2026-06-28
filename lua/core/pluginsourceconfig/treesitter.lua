-- ============================================================
-- TREESITTER — syntax, indentation, text objects, auto-tags
-- Classic Treesitter branch (master) to support modern plugins
-- ============================================================

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch       = "master", -- CLASSIC branch with require('nvim-treesitter.configs') support
    event        = { "BufReadPre", "BufNewFile" },
    build        = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "windwp/nvim-ts-autotag",
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        -- ── Parsers ─────────────────────────────────────────────
        ensure_installed = {
          -- Web
          "javascript", "typescript", "tsx", "html", "css",
          "json", "jsonc", "graphql", "svelte",
          -- Backend
          "go", "rust", "python", "java",
          -- Data / config
          "yaml", "toml", "prisma",
          -- Docs / shell
          "markdown", "markdown_inline", "bash", "dockerfile",
          -- Neovim / tooling
          "lua", "vim", "vimdoc", "query", "gitignore",
        },
        auto_install = true,

        -- ── Core features ────────────────────────────────────────
        highlight = { enable = true },
        indent    = { enable = true },

        -- ── Incremental selection ────────────────────────────────
        incremental_selection = {
          enable  = true,
          keymaps = {
            init_selection    = "<C-space>",
            node_incremental  = "<C-space>",
            scope_incremental = false,
            node_decremental  = "<bs>",
          },
        },

        -- ── Text objects ─────────────────────────────────────────
        textobjects = {
          select = {
            enable    = true,
            lookahead = true,
            keymaps = {
              ["af"] = { query = "@function.outer", desc = "Around function" },
              ["if"] = { query = "@function.inner", desc = "Inside function" },
              ["ac"] = { query = "@class.outer",    desc = "Around class" },
              ["ic"] = { query = "@class.inner",    desc = "Inside class" },
              ["aa"] = { query = "@parameter.outer", desc = "Around argument" },
              ["ia"] = { query = "@parameter.inner", desc = "Inside argument" },
              ["ab"] = { query = "@block.outer",     desc = "Around block" },
              ["ib"] = { query = "@block.inner",     desc = "Inside block" },
            },
          },
          move = {
            enable              = true,
            set_jumps           = true,
            goto_next_start     = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
            goto_next_end       = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
            goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
            goto_previous_end   = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
          },
          swap = {
            enable        = true,
            swap_next     = { ["<leader>sp"] = "@parameter.inner" },
            swap_previous = { ["<leader>sP"] = "@parameter.inner" },
          },
        },
      })

      -- nvim-ts-autotag: setup
      require("nvim-ts-autotag").setup({
        opts = {
          enable_close          = true,
          enable_rename         = true,
          enable_close_on_slash = true,
        },
      })
    end,
  },
}
