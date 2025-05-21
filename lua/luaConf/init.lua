-- A nixCats specific lze handler that you can use to conditionally enable by category easier.
-- at the start of your config, register with
-- require('lze').register_handlers(require('nixCatsUtils.lzUtils').for_cat)
-- before any calls to require('lze').load using the handler have been made.
-- accepts:
-- for_cat = { "your" "cat" };
-- for_cat = { cat = { "your" "cat" }, default = bool }
-- for_cat = "your.cat";
-- for_cat = { cat = "your.cat", default = bool }
-- where default is an alternate value for when nixCats was NOT used to install the config
local for_cat = {
    spec_field = "for_cat",
    set_lazy = false,
    modify = function(plugin)
        if type(plugin.for_cat) == "table" and plugin.for_cat.cat ~= nil then
            if vim.g[ [[nixCats-special-rtp-entry-nixCats]] ] ~= nil then
                plugin.enabled = nixCats(plugin.for_cat.cat) or false
            else
                plugin.enabled = plugin.for_cat.default
            end
        else
            plugin.enabled = nixCats(plugin.for_cat) or false
        end
        return plugin
    end,
}

local catUtils = require('nixCatsUtils')
if (catUtils.isNixCats and nixCats('lspDebugMode')) then
  vim.lsp.set_log_level("debug")
end

-- NOTE: register an extra lze handler with the spec_field 'for_cat'
-- that makes enabling an lze spec for a category slightly nicer
require("lze").register_handlers(for_cat)

-- NOTE: Register another one from lzextras. This one makes it so that
-- you can set up lsps within lze specs,
-- and trigger lspconfig setup hooks only on the correct filetypes
require("lze").register_handlers(require('lzextras').lsp)
-- demonstrated in ./LSPs/init.lua

-- NOTE: Activates plugins folder
require("luaConf.plugins")

-- NOTE: Activates LSPs
require("luaConf.LSP")
