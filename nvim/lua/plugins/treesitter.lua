--- @module 'lazy'
--- @module 'nvim-treesitter'
--- @module 'treesitter-context'

--- @type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    opts = {},
    init = function()
      require("nvim-treesitter").install({
        "bash",
        "css",
        "dockerfile",
        "go",
        "gomod",
        "gosum",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "sql",
        "templ",
        "toml",
        "tsx",
        "typescript",
        "typst",
        "yaml",
      })

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("treesitter.setup", { clear = true }),
        callback = function(args)
          local buf = args.buf
          local filetype = args.match

          -- you need some mechanism to avoid running on buffers that do not
          -- correspond to a language (like oil.nvim buffers), this implementation
          -- checks if a parser exists for the current language
          local language = vim.treesitter.language.get_lang(filetype) or filetype
          if not vim.treesitter.language.add(language) then
            return
          end

          vim.wo.foldmethod = "expr"
          vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"

          vim.treesitter.start(buf, language)

          vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,

    require("vim.treesitter.query").add_predicate("is-mise?", function(_, _, bufnr, _)
      local filepath = vim.api.nvim_buf_get_name(tonumber(bufnr) or 0)
      local filename = vim.fn.fnamemodify(filepath, ":t")
      return string.match(filename, ".*mise.*%.toml$") ~= nil
    end, { force = true, all = false }),
  },

  { "nvim-treesitter/nvim-treesitter-context" },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    ---@type TSTextObjects.Config
    opts = {
      select = {
        lookahead = true,
        include_surrounding_whitespace = true,
      },
      move = {
        set_jumps = true,
      },
    },
    init = function()
      local ts_select = require("nvim-treesitter-textobjects.select")

      vim.keymap.set({ "x", "o" }, "af", function()
        ts_select.select_textobject("@function.outer", "textobjects")
      end)
      vim.keymap.set({ "x", "o" }, "if", function()
        ts_select.select_textobject("@function.inner", "textobjects")
      end)
      vim.keymap.set({ "x", "o" }, "ac", function()
        ts_select.select_textobject("@class.outer", "textobjects")
      end)
      vim.keymap.set({ "x", "o" }, "ic", function()
        ts_select.select_textobject("@class.inner", "textobjects")
      end)
    end,
  },
}
