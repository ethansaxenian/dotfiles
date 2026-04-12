vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == "luasnip" and (kind == "install" or kind == "update") then
      if not ev.data.active then
        vim.cmd.packadd("luasnip")
      end
      vim.cmd("make install_jsregexp")
    end
  end,
})

vim.pack.add({
  "https://github.com/rafamadriz/friendly-snippets",
  { src = "https://github.com/L3MON4D3/LuaSnip", version = vim.version.range("v2.*") },
})

local ls = require("luasnip")

vim.keymap.set({ "i", "s" }, "<C-n>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true, desc = "luasnip.expand_or_jump()" })

vim.keymap.set({ "i", "s" }, "<C-p>", function()
  if ls.expand_or_jumpable() then
    ls.jump(-1)
  end
end, { silent = true, desc = "luasnip.jump(-1)" })

require("luasnip.loaders.from_lua").lazy_load()
require("luasnip.loaders.from_vscode").lazy_load()
