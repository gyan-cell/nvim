-- ============================================================
-- SESSION RESTORE — auto-session
-- ============================================================

return {
  "rmagatti/auto-session",
  lazy = false,
  opts = {
    auto_restore  = false,
    suppressed_dirs = {
      "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/",
    },
    log_level = "error",  -- only show errors (suppress info spam)
    git_use_branch_name = true,  -- separate session per git branch
    -- Auto-close NvimTree to prevent Vim:E95 buffer conflicts on restore
    pre_save_cmds = { "NvimTreeClose" },
    post_restore_cmds = { "NvimTreeClose" },
  },
  config = function(_, opts)
    require("auto-session").setup(opts)

    local map = vim.keymap.set
    map("n", "<leader>wr", "<cmd>SessionRestore<cr>", { desc = "Restore session (cwd)" })
    map("n", "<leader>ws", "<cmd>SessionSave<cr>",    { desc = "Save session (cwd)" })
    map("n", "<leader>wd", "<cmd>SessionDelete<cr>",  { desc = "Delete session (cwd)" })
  end,
}
