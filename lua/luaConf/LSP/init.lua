local catUtils = require('nixCatsUtils')
if (catUtils.isNixCats and nixCats('lspDebugMode')) then
  vim.lsp.set_log_level("debug")
end
return {
require('lze').load {
        {
                "nvim-lspconfig",
                for_cat = "general.core",
                on_require = { "lspconfig" },
                lsp = function(plugin)
                        require('lspconfig')[plugin.name].setup(vim.tbl_extend("force",{
                                capabilities = require('luaConf.LSP.caps_on_attach').get_capabilities(plugin.name),
                                on_attach = require('luaConf.LSP.caps_on_attach').on_attach,
                        }, plugin.lsp or {}))
                end,
        },
        {
                "lazydev.nvim",
                for_cat = "neonixdev",
                cmd = { "LazyDev" },
                ft = "lua",
                after = function(_)
                        require('lazydev').setup({
                                library = {
                                        { words = { "nixCats" }, path = (nixCats.nixCatsPath or "") .. '/lua' },
                                },
                        })
                end,
        },
        {
                "lua_ls",
                enabled = nixCats('lua') or nixCats('neonixdev') or false,
                lsp = {
                        filetypes = { 'lua' },
                        settings = {
                                Lua = {
                                        runtime = { version = 'LuaJIT' },
                                        formatters = {
                                                ignoreComments = true,
                                                command = { "stylua" },
                                        },
                                        signatureHelp = { enabled = true, },
                                        diagnostics = {
                                                globals = { "nixCats", "vim", },
                                                disable = { 'missing-fields' },
                                        },
                                        telemetry = { enabled = false },
                                },
                        },
                },
        },
{
    "nixd",
    enabled = catUtils.isNixCats and (nixCats('nix') or nixCats('neonixdev')) or false,
    lsp = {
      filetypes = { "nix" },
      settings = {
        nixd = {
          -- nixd requires some configuration.
          -- luckily, the nixCats plugin is here to pass whatever we need!
          -- we passed this in via the `extra` table in our packageDefinitions
          -- for additional configuration options, refer to:
          -- https://github.com/nix-community/nixd/blob/main/nixd/docs/configuration.md
          nixpkgs = {
            -- in the extras set of your package definition:
            -- nixdExtras.nixpkgs = ''import ${pkgs.path} {}''
            expr = nixCats.extra("nixdExtras.nixpkgs") or [[import <nixpkgs> {}]],
          },
          options = {
            -- If you integrated with your system flake,
            -- you should use inputs.self as the path to your system flake
            -- that way it will ALWAYS work, regardless
            -- of where your config actually was.
            nixos = {
              -- nixdExtras.nixos_options = ''(builtins.getFlake "path:${builtins.toString inputs.self.outPath}").nixosConfigurations.configname.options''
              expr = nixCats.extra("nixdExtras.nixos_options")
            },
            -- If you have your config as a separate flake, inputs.self would be referring to the wrong flake.
            -- You can override the correct one into your package definition on import in your main configuration,
            -- or just put an absolute path to where it usually is and accept the impurity.
            ["home-manager"] = {
              -- nixdExtras.home_manager_options = ''(builtins.getFlake "path:${builtins.toString inputs.self.outPath}").homeConfigurations.configname.options''
              expr = nixCats.extra("nixdExtras.home_manager_options")
            }
          },
          formatting = {
            command = { "nixfmt" }
          },
          diagnostic = {
            suppress = {
              "sema-escaping-with"
            }
          }
        }
      },
        },

        },
        }
}
