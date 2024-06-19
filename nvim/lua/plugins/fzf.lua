return {
  "ibhagwan/fzf-lua",
  dependencies = { "junegunn/fzf" },
  opts = {
    winopts = {
      fullscreen = true,
      preview = { horizontal = "right:50%" },
    },
    keymap = {
      builtin = {
        ["<F1>"] = "toggle-help",
        ["<C-w>"] = "toggle-preview-wrap",
        ["<C-p>"] = "toggle-preview",
        ["<C-/>"] = "toggle-preview-cw",
        ["<M-n>"] = "preview-down",
        ["<M-p>"] = "preview-up",
        ["<M-j>"] = "preview-page-down",
        ["<M-k>"] = "preview-page-up",
      },
    },
    fzf_opts = {
      ["--layout"] = "default",
    },
    lsp = {
      symbols = {
        symbol_style = 3,
      },
    },
  },
  config = function(_, opts)
    local fzf = require("fzf-lua")
    fzf.setup(opts)

    vim.keymap.set("n", "<leader>b", fzf.buffers)
    vim.keymap.set("n", "<leader>f", fzf.files)
    vim.keymap.set("n", "<leader>g", fzf.live_grep_native)
    vim.keymap.set("n", "<leader>h", fzf.helptags)
    vim.keymap.set("n", "<leader>ch", fzf.command_history)
    vim.keymap.set("n", "<leader>r", fzf.registers)
    vim.keymap.set("n", "<leader>q", fzf.quickfix)
    vim.keymap.set("n", "<leader>l", fzf.loclist)
    vim.keymap.set("n", "<leader>ds", fzf.lsp_document_symbols)
    vim.keymap.set("n", "<leader>ws", fzf.lsp_live_workspace_symbols)
  end,
}
