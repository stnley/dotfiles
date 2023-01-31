local highlight_yank = vim.api.nvim_create_augroup("highlight_yank", {})
vim.api.nvim_create_autocmd("TextYankPost", {
  group = highlight_yank,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ timeout = 75 })
  end,
  desc = "highlight yanked text",
})

local remove_whitespace = vim.api.nvim_create_augroup("remove_whitespace", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  group = remove_whitespace,
  pattern = "*",
  command = [[ %s/\s\+$//e ]],
  desc = "remove trailing whitespace from each line when saving buffer",
})
