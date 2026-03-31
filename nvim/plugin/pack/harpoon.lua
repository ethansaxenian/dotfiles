vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",
  { src = "https://github.com/ThePrimeagen/harpoon", version = "harpoon2" },
})

local harpoon = require("harpoon")

vim.keymap.set("n", "<leader>ha", function()
  harpoon:list():add()
end, { desc = "add to harpoon list" })

vim.keymap.set("n", "<leader>ho", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "view harpoon list" })

for i = 1, 9 do
  vim.keymap.set("n", "<leader>" .. i, function()
    harpoon:list():select(i)
  end, { desc = "harpoon select " .. i })
end

vim.keymap.set("n", "<leader>0", function()
  harpoon:list():select(10)
end, { desc = "harpoon select 10" })
