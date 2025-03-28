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
  },
  init = function()
    vim.keymap.set("n", "<leader>b", require("fzf-lua").buffers)
    vim.keymap.set("n", "<leader>f", require("fzf-lua").files)
    vim.keymap.set("n", "<leader>g", require("fzf-lua").live_grep_native)
    vim.keymap.set("n", "<leader>sh", require("fzf-lua").helptags)
    vim.keymap.set("n", "<leader>ch", require("fzf-lua").command_history)
    vim.keymap.set("n", "<leader>r", require("fzf-lua").registers)
    vim.keymap.set("n", "<leader>q", require("fzf-lua").quickfix)
    vim.keymap.set("n", "<leader>l", require("fzf-lua").loclist)
    vim.keymap.set("n", "<leader>ds", require("fzf-lua").lsp_document_symbols)
    vim.keymap.set("n", "<leader>ws", require("fzf-lua").lsp_live_workspace_symbols)
  end,
}
