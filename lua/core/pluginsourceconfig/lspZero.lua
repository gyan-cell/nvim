return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    lazy = true,
    config = false,
    init = function()
      vim.g.lsp_zero_extend_cmp = 0
      vim.g.lsp_zero_extend_lspconfig = 0
    end,
  },
  {
    'williamboman/mason.nvim',
    lazy = false,
    config = true,
  },
  {
    'neovim/nvim-lspconfig',
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'williamboman/mason-lspconfig.nvim' },
    },
    config = function()
      local lsp_zero = require('lsp-zero')
      lsp_zero.extend_lspconfig()

      lsp_zero.on_attach(function(client, bufnr)
        lsp_zero.default_keymaps({ buffer = bufnr })
      end)

      lsp_zero.set_sign_icons({
        error = '✘',
        warn = '▲',
        hint = '⚑',
        info = '»'
      })

      require('mason-lspconfig').setup({
        ensure_installed = {
          'ts_ls', 'rust_analyzer', 'clangd', 'pyright', 'lua_ls',
          'cssls', 'tailwindcss', 'prismals', 'html', "gopls"
          -- Don't include jdtls in ensure_installed since we're installing manually
        },
        handlers = {
          lsp_zero.default_setup,
          lua_ls = function()
            local lua_opts = lsp_zero.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)
          end,
        }
      })

      -- Manual jdtls setup for Java 17
      local home = os.getenv("HOME")
      local jdtls_path = home .. "/.local/share/nvim/mason/packages/jdtls"

      -- Check if we have the compatible version
      local launcher = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
      if vim.fn.filereadable(launcher) == 0 then
        vim.notify("jdtls for Java 17 not found. Run the installation script.", vim.log.levels.WARN)
        return
      end

      local config_dir = jdtls_path .. "/config_linux"
      local workspace_dir = home .. "/.cache/jdtls/workspace"

      -- Create workspace directory if it doesn't exist
      os.execute("mkdir -p " .. workspace_dir)

      require('lspconfig').jdtls.setup({
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
          "-jar", launcher,
          "-configuration", config_dir,
          "-data", workspace_dir,
        },
        root_dir = require('lspconfig.util').root_pattern(
          ".git", "mvnw", "gradlew", "pom.xml", "build.gradle"
        ),
        filetypes = { "java" },
        on_attach = function(client, bufnr)
          lsp_zero.default_keymaps({ buffer = bufnr })
        end,
      })
    end
  }
}
