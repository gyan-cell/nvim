local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- vim.uv is the modern alias for vim.loop (deprecated in Neovim 0.10+)
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("core.pluginsourceconfig", {
  checker = {
    enabled = true,  -- notify when updates are available
    notify = false,  -- silent background check
  },
  change_detection = {
    notify = false,  -- don't notify on config file changes
  },
})
