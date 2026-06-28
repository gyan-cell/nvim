-- ============================================================
-- FORMATTING — conform.nvim
-- ============================================================

return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        -- Web
        javascript      = { "prettier" },
        typescript      = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        svelte          = { "prettier" },
        css             = { "prettier" },
        html            = { "prettier" },
        json            = { "prettier" },
        yaml            = { "prettier" },
        markdown        = { "prettier" },
        graphql         = { "prettier" },
        -- Backend
        go              = { "goimports", "gofmt" },
        python          = { "isort", "black" },
        rust            = { "rustfmt" },
        -- Lua
        lua             = { "stylua" },
      },
      format_on_save = {
        lsp_format = "fallback",  -- updated conform v6+ API (was lsp_fallback)
        async      = false,
        timeout_ms = 1500,
      },
    })

    vim.keymap.set({ "n", "v" }, "<leader>fm", function()
      conform.format({
        lsp_format = "fallback",
        async      = false,
        timeout_ms = 1500,
      })
    end, { desc = "Format file / selection" })
  end,
}
