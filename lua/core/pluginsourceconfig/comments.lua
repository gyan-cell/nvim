-- ============================================================
-- COMMENTS — ts-comments.nvim (modern successor to Comment.nvim)
-- Natively handles JSX/TSX context without extra setup
-- gc / gcc / gbc work as expected
-- ============================================================

return {
  "folke/ts-comments.nvim",
  event  = "VeryLazy",
  opts   = {},  -- uses sensible defaults
}
