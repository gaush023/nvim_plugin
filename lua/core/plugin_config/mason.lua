-- .config/nvim/lua/core/plugin_config/mason.lua

require("mason").setup()
require("mason-lspconfig").setup {
  ensure_installed = { "solargraph" },
}

local lspconfig = require("lspconfig")
lspconfig.solargraph.setup {}
