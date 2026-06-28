-- ============================================================
-- CMP — Completion engine
-- ============================================================

return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer",           -- text in current buffer
    "hrsh7th/cmp-path",             -- filesystem paths
    "hrsh7th/cmp-nvim-lsp",         -- LSP completions
    "L3MON4D3/LuaSnip",             -- snippet engine
    "saadparwaiz1/cmp_luasnip",     -- snippet source
    "rafamadriz/friendly-snippets", -- snippet collection
    "onsails/lspkind.nvim",         -- VS Code-style icons
  },
  config = function()
    local cmp     = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")

    -- Load VS Code-style snippets from friendly-snippets
    require("luasnip.loaders.from_vscode").lazy_load()

    -- Allow luasnip to jump between snippet nodes
    luasnip.config.setup({})

    cmp.setup({
      completion = {
        completeopt = "menu,menuone,preview,noselect",
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      window = {
        completion    = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-p>"]     = cmp.mapping.select_prev_item(),
        ["<C-n>"]     = cmp.mapping.select_next_item(),
        ["<C-b>"]     = cmp.mapping.scroll_docs(-4),
        ["<C-f>"]     = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"]     = cmp.mapping.abort(),
        ["<CR>"]      = cmp.mapping.confirm({ select = false }),
        -- Tab: confirm snippet expansion or move to next item
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp", priority = 1000 },
        { name = "luasnip",  priority = 750 },
        { name = "buffer",   priority = 500 },
        { name = "path",     priority = 250 },
      }),
      formatting = {
        format = lspkind.cmp_format({
          mode       = "symbol_text",
          maxwidth   = 50,
          ellipsis_char = "…",
          before = function(_, vim_item)
            return vim_item
          end,
        }),
      },
      experimental = {
        ghost_text = true,  -- shows a dimmed preview of the first completion
      },
    })
  end,
}
