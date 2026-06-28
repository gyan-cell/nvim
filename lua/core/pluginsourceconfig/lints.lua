-- ============================================================
-- LINTING — nvim-lint
-- ============================================================

return {
  "mfussenegger/nvim-lint",
  -- Fixed: was lazy=true with no event — linter never loaded
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      javascript      = { "eslint_d" },
      typescript      = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      svelte          = { "eslint_d" },
      python          = { "pylint" },
    }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group    = lint_augroup,
      callback = function()
        -- Only lint if the file is saved (not a new unnamed buffer)
        if vim.fn.bufname() ~= "" then
          lint.try_lint()
        end
      end,
    })

    vim.keymap.set("n", "<leader>lL", function()
      lint.try_lint()
    end, { desc = "Trigger lint (manual)" })
  end,
}
