-- Load options first so they apply during plugin setup
require("core.options")
require("core.plugins")
require("core.mappings")

-- Load persisted theme choice (overrides the default colorscheme if user has picked one)
vim.schedule(function()
  require("core.themepicker").load_saved()
end)
