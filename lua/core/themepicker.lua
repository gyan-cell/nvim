-- ============================================================
-- KAUMUDI THEME PICKER — Telescope-powered colorscheme selector
-- Usage: <leader>tt
-- Persists your selection to ~/.local/share/nvim/theme.txt
-- Only applies when selection is confirmed with <CR> (no dynamic lag/flash)
-- Shows all premium themes and variants (even if lazy-loaded)!
-- ============================================================

local M = {}

-- Static list of all premium themes and their gorgeous variants
local function get_available_themes()
  return {
    { name = "catppuccin-mocha",      label = "☕ Catppuccin Mocha" },
    { name = "catppuccin-macchiato",  label = "🍫 Catppuccin Macchiato" },
    { name = "catppuccin-frappe",     label = "🧁 Catppuccin Frappe" },
    { name = "catppuccin-latte",      label = "🥛 Catppuccin Latte" },
    { name = "tokyonight-night",      label = "🌃 Tokyo Night" },
    { name = "tokyonight-storm",      label = "⛈  Tokyo Storm" },
    { name = "tokyonight-day",        label = "☀️  Tokyo Day" },
    { name = "tokyonight-moon",       label = "🌙 Tokyo Moon" },
    { name = "rose-pine",             label = "🌸 Rose Pine Moon" },
    { name = "rose-pine-main",        label = "🌹 Rose Pine Main" },
    { name = "rose-pine-dawn",        label = "🌤  Rose Pine Dawn" },
    { name = "kanagawa-dragon",       label = "🐉 Kanagawa Dragon" },
    { name = "kanagawa-wave",         label = "🌊 Kanagawa Wave" },
    { name = "kanagawa-lotus",        label = "🪷 Kanagawa Lotus" },
    { name = "gruvbox-material",      label = "🪵 Gruvbox Material" },
    { name = "oxocarbon",             label = "🔵 Oxocarbon" },
    { name = "unokai",                label = "🎨 Unokai" },
  }
end

local persist_path = vim.fn.stdpath("data") .. "/theme.txt"

-- Save theme name to disk
local function save_theme(name)
  local f = io.open(persist_path, "w")
  if f then
    f:write(name)
    f:close()
  end
end

-- Load saved theme (called from init on startup)
function M.load_saved()
  local f = io.open(persist_path, "r")
  if f then
    local name = f:read("*l")
    f:close()
    if name and name ~= "" then
      pcall(vim.cmd, "colorscheme " .. name)
    end
  end
end

-- Apply a theme with error handling
local function apply_theme(name)
  local ok, err = pcall(vim.cmd, "colorscheme " .. name)
  if not ok then
    vim.notify("Theme error: " .. tostring(err), vim.log.levels.ERROR)
  end
end

-- Open the picker
function M.pick()
  local pickers     = require("telescope.pickers")
  local finders     = require("telescope.finders")
  local conf        = require("telescope.config").values
  local actions     = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  local themes = get_available_themes()

  pickers.new({}, {
    prompt_title = "  Theme Picker",
    finder = finders.new_table({
      results = themes,
      entry_maker = function(entry)
        return {
          value   = entry.name,
          display = entry.label,
          ordinal = entry.label,
        }
      end,
    }),
    sorter = conf.generic_sorter({}),
    previewer = false,
    attach_mappings = function(prompt_bufnr, _)
      -- Confirm: save + keep
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local entry = action_state.get_selected_entry()
        if entry then
          apply_theme(entry.value)
          save_theme(entry.value)
          vim.notify("Theme set to: " .. entry.display, vim.log.levels.INFO)
        end
      end)

      return true
    end,
  }):find()
end

return M
