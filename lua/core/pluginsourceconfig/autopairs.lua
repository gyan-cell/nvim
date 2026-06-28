-- ============================================================
-- AUTOPAIRS — auto-close brackets, quotes, etc.
-- ============================================================

return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  opts = {
    check_ts    = true,  -- use treesitter for smarter pairing
    ts_config   = {
      lua  = { "string" },   -- don't pair in lua strings
      javascript = { "template_string" },
    },
    disable_filetype = { "TelescopePrompt", "vim" },
  },
}
