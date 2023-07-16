vim.b.format_on = true

function Format(cmd, args)
   if (not vim.b.format_on or vim.fn.executable(cmd) == 0) then
      return
   end

   cmd = cmd .. " " .. args .. " 2>&1"
   local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
   local output = vim.fn.system(cmd, lines)

   if vim.v.shell_error ~= 0 then
      vim.notify('Error formatting:\n\n' .. output, vim.log.levels.ERROR, { title = "Formatter error" })
      return
   end

   vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.fn.split(output, "\n"))
end

vim.api.nvim_create_user_command("ToggleFormat", function()
   vim.b.format_on = not vim.b.format_on
   print("Format on save: " .. tostring(vim.b.format_on))
end, {})
