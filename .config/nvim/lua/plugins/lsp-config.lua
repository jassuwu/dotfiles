return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "j-hui/fidget.nvim",
  },

  config = function()
    local cmp = require('cmp')
    local cmp_lsp = require("cmp_nvim_lsp")
    local capabilities = vim.tbl_deep_extend(
    "force",
    {},
    vim.lsp.protocol.make_client_capabilities(),
    cmp_lsp.default_capabilities())
    local util = require("lspconfig/util")

    require("fidget").setup({})
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",

        "gopls",

        "clangd",

        "elixirls",

        "ts_ls",
        "tailwindcss",
        "eslint",
        -- prettierd doesn't get installed for some reason. manually install it with Mason.
        -- "prettierd",

        "pyright",
      },
      automatic_installation = true,
      handlers = {
        function(server_name) -- default handler (optional)

          require("lspconfig")[server_name].setup {
            capabilities = capabilities
          }
        end,

        ["lua_ls"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.lua_ls.setup {
            capabilities = capabilities,
            settings = {
              Lua = {
                runtime = { version = "Lua 5.1" },
                diagnostics = {
                  globals = { "vim", "it", "describe", "before_each", "after_each" },
                }
              }
            }
          }
        end,

        ["gopls"] = function ()
          local lspconfig = require("lspconfig")
          lspconfig.gopls.setup {
            capabilities = capabilities,
            cmd = {"gopls"},
            filetypes = {"go", "gomod", "gowork", "gotmpl"},
            root_dir = util.root_pattern("go.work", "go.mod", ".git"),
            settings = {
              gopls = {
                completeUnimported = true,
                usePlaceholders = true,
                analyses = {
                  unusedparams = true,
                }
              }
            }
          }
        end,

        ["tailwindcss"] = function ()
          local lspconfig = require("lspconfig")
          lspconfig.tailwindcss.setup {
            root_dir = util.root_pattern("tailwind.config.js", "tailwind.config.ts")
          }
        end,

        ["eslint"] = function ()
          local lspconfig = require("lspconfig")
          lspconfig.eslint.setup {
            root_dir = util.root_pattern("eslint.config.js", "eslint.config.ts", "eslint.config.mjs", "eslint.config.cjs", "eslint.config.mts", "eslint.config.cts")
          }
        end,

        ["pyright"] = function ()
          local lspconfig = require("lspconfig")
          lspconfig.pyright.setup {
            root_dir = util.root_pattern("pyproject.toml","setup.py", "setup.cfg", "requirements.txt", "Pipfile", "pyrightconfig.json", ".git"),
            single_file_support = true,
            settings = {
              python = {
                analysis = {
                  autoSearchPaths = true,
                  useLibraryCodeForTypes = true,
                }
              },
            }
          }
        end
      }
    })

    local cmp_select = { behavior = cmp.SelectBehavior.Select }

    cmp.setup({
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' }, -- For luasnip users.
      }, {
        { name = 'buffer' },
      })
    })

    vim.diagnostic.config({
      -- update_in_insert = true,
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    })
  end
}
