function Format(cmd)
   cmd = cmd .. " 2>&1"
   local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
   local output = vim.fn.system(cmd, lines)
   if vim.v.shell_error ~= 0 then
      vim.notify('Error formatting:\n\n' .. output, vim.log.levels.ERROR, { title = "Formatter error" })
      return
   end

   vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.fn.split(output, "\n"))
end
