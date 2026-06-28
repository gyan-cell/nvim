-- ============================================================
-- HARPOON 2 — fast file navigation
-- ============================================================

return {
  "ThePrimeagen/harpoon",
  branch       = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup({
      settings = {
        save_on_toggle = true,
        sync_on_ui_close = true,
      },
    })

    local map = vim.keymap.set

    -- Add current file to harpoon list
    map("n", "<leader>a", function() harpoon:list():add() end,
        { desc = "Harpoon: add file" })
    map("n", "<leader>ha", function() harpoon:list():add() end,
        { desc = "Harpoon: add file" })

    -- Toggle quick menu
    map("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
        { desc = "Harpoon: toggle menu" })
    map("n", "<leader>he", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
        { desc = "Harpoon: toggle menu" })

    -- Navigate to specific files (fixed: was all calling index 4)
    map("n", "<C-1>", function() harpoon:list():select(1) end, { desc = "Harpoon: file 1" })
    map("n", "<C-2>", function() harpoon:list():select(2) end, { desc = "Harpoon: file 2" })
    map("n", "<C-3>", function() harpoon:list():select(3) end, { desc = "Harpoon: file 3" })
    map("n", "<C-4>", function() harpoon:list():select(4) end, { desc = "Harpoon: file 4" })
    map("n", "<C-5>", function() harpoon:list():select(5) end, { desc = "Harpoon: file 5" })
    map("n", "<C-6>", function() harpoon:list():select(6) end, { desc = "Harpoon: file 6" })
    map("n", "<C-7>", function() harpoon:list():select(7) end, { desc = "Harpoon: file 7" })

    -- Easy leader-prefixed navigation to files
    map("n", "<leader>h1", function() harpoon:list():select(1) end, { desc = "Harpoon: file 1" })
    map("n", "<leader>h2", function() harpoon:list():select(2) end, { desc = "Harpoon: file 2" })
    map("n", "<leader>h3", function() harpoon:list():select(3) end, { desc = "Harpoon: file 3" })
    map("n", "<leader>h4", function() harpoon:list():select(4) end, { desc = "Harpoon: file 4" })
    map("n", "<leader>h5", function() harpoon:list():select(5) end, { desc = "Harpoon: file 5" })
    map("n", "<leader>h6", function() harpoon:list():select(6) end, { desc = "Harpoon: file 6" })
    map("n", "<leader>h7", function() harpoon:list():select(7) end, { desc = "Harpoon: file 7" })

    -- Previous / next in harpoon list
    map("n", "<leader>hp", function() harpoon:list():prev() end, { desc = "Harpoon: prev" })
    map("n", "<leader>hn", function() harpoon:list():next() end, { desc = "Harpoon: next" })
  end,
}
