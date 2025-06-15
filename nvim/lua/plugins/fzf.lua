--- @module 'lazy'
--- @type LazySpec
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
    local fzf_lua = require("fzf-lua")

    vim.keymap.set("n", "<leader>b", fzf_lua.buffers)
    vim.keymap.set("n", "<leader>f", fzf_lua.files)
    vim.keymap.set("n", "<leader>g", fzf_lua.live_grep_native)
    vim.keymap.set("n", "<leader>sh", fzf_lua.helptags)
    vim.keymap.set("n", "<leader>ch", fzf_lua.command_history)
    vim.keymap.set("n", "<leader>r", fzf_lua.registers)
    vim.keymap.set("n", "<leader>q", fzf_lua.quickfix)
    vim.keymap.set("n", "<leader>l", fzf_lua.loclist)
    vim.keymap.set("n", "<leader>ds", fzf_lua.lsp_document_symbols)
    vim.keymap.set("n", "<leader>ws", fzf_lua.lsp_live_workspace_symbols)
  end,
}
