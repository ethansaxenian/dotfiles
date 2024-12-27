return {
  "ibhagwan/fzf-lua",
  opts = {
    winopts = {
      fullscreen = true,
      preview = {
        horizontal = "right:50%",
        vertical = "up:50%",
        scrollbar = "float",
      },
    },
    hls = {
      border = "Comment",
      preview_border = "Comment",
    },
    keymap = {
      builtin = {
        ["<F1>"] = "toggle-help",
        ["<C-w>"] = "toggle-preview-wrap",
        ["<C-p>"] = "toggle-preview",
        ["<M-j>"] = "preview-down",
        ["<M-k>"] = "preview-up",
        ["<M-d>"] = "preview-page-down",
        ["<M-u>"] = "preview-page-up",
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
  init = function()
    local fzf = require("fzf-lua")
    vim.keymap.set("n", "<leader>b", fzf.buffers)
    vim.keymap.set("n", "<leader>f", fzf.files)
    vim.keymap.set("n", "<leader>g", fzf.live_grep_native)
    vim.keymap.set("n", "<leader>sh", fzf.helptags)
    vim.keymap.set("n", "<leader>ch", fzf.command_history)
    vim.keymap.set("n", "<leader>r", fzf.registers)
    vim.keymap.set("n", "<leader>q", fzf.quickfix)
    vim.keymap.set("n", "<leader>l", fzf.loclist)
    vim.keymap.set("n", "<leader>ds", fzf.lsp_document_symbols)
    vim.keymap.set("n", "<leader>ws", fzf.lsp_live_workspace_symbols)
  end,
}
