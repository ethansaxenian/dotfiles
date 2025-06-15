--- @module 'lazy'
--- @type LazySpec
return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    init = function()
      local harpoon = require("harpoon")

      vim.keymap.set("n", "<leader>ha", function()
        harpoon:list():add()
      end)

      vim.keymap.set("n", "<leader>ho", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end)

      for i = 1, 9 do
        vim.keymap.set("n", "<leader>" .. i, function()
          harpoon:list():select(i)
        end)
      end

      vim.keymap.set("n", "<leader>0", function()
        harpoon:list():select(10)
      end)
    end,
  },
}
