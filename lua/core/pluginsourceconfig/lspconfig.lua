-- ============================================================
-- LSP CONFIG — mason + mason-lspconfig + native vim.lsp API
-- Fully compatible with Neovim 0.11+ / 0.12+ (native LSP config)
-- ============================================================

return {
  -- Mason: LSP/formatter/linter installer
  {
    "williamboman/mason.nvim",
    lazy   = false,
    config = true,
  },

  -- Bridges mason ↔ lspconfig (auto-installs + auto-enables servers)
  {
    "williamboman/mason-lspconfig.nvim",
    lazy         = false,
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      ensure_installed = {
        "ts_ls", "rust_analyzer", "clangd", "pyright", "lua_ls",
        "cssls", "tailwindcss", "prismals", "html", "gopls", "jdtls",
      },
      automatic_installation = true,
    },
  },

  -- nvim-lspconfig provides default server configs that vim.lsp.config() merges
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- ── Diagnostic sign icons (modern API) ──────────────────
      vim.diagnostic.config({
        virtual_text = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "✘",
            [vim.diagnostic.severity.WARN]  = "▲",
            [vim.diagnostic.severity.HINT]  = "⚑",
            [vim.diagnostic.severity.INFO]  = "»",
          },
        },
        underline        = true,
        update_in_insert = false,
        float = {
          border = "rounded",
          source = true,
        },
      })

      -- ── LspAttach: keymaps applied whenever any LSP attaches ──
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspKeymaps", { clear = true }),
        callback = function(ev)
          local bufnr  = ev.buf
          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
          end

          map("gd",         vim.lsp.buf.definition,       "Go to definition")
          map("gD",         vim.lsp.buf.declaration,      "Go to declaration")
          map("gi",         vim.lsp.buf.implementation,   "Go to implementation")
          map("gr",         vim.lsp.buf.references,       "List references")
          map("gt",         vim.lsp.buf.type_definition,  "Go to type definition")
          map("K",          function() vim.lsp.buf.hover({ border = "rounded" }) end, "Hover docs")
          map("<C-k>",      function() vim.lsp.buf.signature_help({ border = "rounded" }) end, "Signature help")
          map("<leader>rn", vim.lsp.buf.rename,           "Rename symbol")
          map("<leader>ca", vim.lsp.buf.code_action,      "Code action")
          map("<leader>rs", "<cmd>LspRestart<cr>",        "Restart LSP")
          map("<leader>li", "<cmd>LspInfo<cr>",           "LSP info")

          -- Easy leader-prefixed LSP mappings
          map("<leader>ld", vim.lsp.buf.definition,       "Go to definition")
          map("<leader>lD", vim.lsp.buf.declaration,      "Go to declaration")
          map("<leader>lI", vim.lsp.buf.implementation,   "Go to implementation")
          map("<leader>lr", vim.lsp.buf.references,       "List references")
          map("<leader>lt", vim.lsp.buf.type_definition,  "Go to type definition")
          map("<leader>lh", function() vim.lsp.buf.hover({ border = "rounded" }) end, "Hover docs")
          map("<leader>ls", function() vim.lsp.buf.signature_help({ border = "rounded" }) end, "Signature help")
          map("<leader>la", vim.lsp.buf.code_action,      "Code action")
          map("<leader>ln", vim.lsp.buf.rename,           "Rename symbol")
          map("<leader>lR", "<cmd>LspRestart<cr>",        "Restart LSP")

          -- Enable inlay hints if supported
          if client and client:supports_method("textDocument/inlayHint") then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
            map("<leader>ih", function()
              vim.lsp.inlay_hint.enable(
                not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }),
                { bufnr = bufnr }
              )
            end, "Toggle inlay hints")
          end
        end,
      })

      -- ── Shared defaults for ALL servers ─────────────────────
      vim.lsp.config("*", {
        capabilities = capabilities,
      })

      -- ── Server-specific configs ─────────────────────────────

      -- Lua LS with Neovim globals
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            runtime     = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace   = {
              library         = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry   = { enable = false },
            hint        = { enable = true },
          },
        },
      })

      -- JDTLS (Automated install via Mason)
      local home       = os.getenv("HOME")
      local jdtls_path = home .. "/.local/share/nvim/mason/packages/jdtls"
      local launcher   = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")

      if vim.fn.filereadable(launcher) == 1 then
        os.execute("mkdir -p " .. home .. "/.cache/jdtls/workspace")
        vim.lsp.config("jdtls", {
          cmd = {
            "java",
            "-Declipse.application=org.eclipse.jdt.ls.core.id1",
            "-Dosgi.bundles.defaultStartLevel=4",
            "-Declipse.product=org.eclipse.jdt.ls.core.product",
            "-Dlog.protocol=true",
            "-Dlog.level=ALL",
            "-Xms1g",
            "--add-modules=ALL-SYSTEM",
            "--add-opens", "java.base/java.util=ALL-UNNAMED",
            "--add-opens", "java.base/java.lang=ALL-UNNAMED",
            "-jar",           launcher,
            "-configuration", jdtls_path .. "/config_linux",
            "-data",          home .. "/.cache/jdtls/workspace",
          },
          root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" },
          filetypes = { "java" },
        })
      end

      -- ── Enable all servers ──────────────────────────────────
      -- mason-lspconfig auto-enables ensure_installed servers,
      -- but we also call vim.lsp.enable() explicitly so they
      -- register even if mason-lspconfig hasn't run yet.
      vim.lsp.enable({
        "ts_ls", "rust_analyzer", "clangd", "pyright", "lua_ls",
        "cssls", "tailwindcss", "prismals", "html", "gopls", "jdtls",
      })
    end,
  },
}
