return {
  "samodostal/image.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    backend = "ueberzug", -- Explicitly use Kitty
    integrations = {
      markdown = {
        enabled = true, -- Preview images in markdown
      },
    },
    max_width = 100, -- Limit image width
    max_height = 12, -- Limit height (rows)
  },
  ft = { "png", "jpg", "jpeg", "gif", "webp", "md" },
}
