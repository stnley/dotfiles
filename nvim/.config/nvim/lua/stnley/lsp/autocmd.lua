local M = {}

local highlight_group = vim.api.nvim_create_augroup("lsp_highlights", {})
local codelens_group = vim.api.nvim_create_augroup("lsp_codelens", {})
local format_group = vim.api.nvim_create_augroup("lsp_formatting", {})

M.highlight_on_hover = function()
  vim.api.nvim_clear_autocmds({ group = highlight_group })
  vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
    group = highlight_group,
    pattern = "<buffer>",
    callback = function()
      vim.lsp.buf.document_highlight()
    end,
    desc = "highlight references to symbol under cursor",
  })

  vim.api.nvim_create_autocmd("CursorMoved", {
    group = highlight_group,
    pattern = "<buffer>",
    callback = function()
      vim.lsp.buf.clear_references()
    end,
    desc = "clear highlight references to symbol under cursor",
  })
end

M.codelens_refresh = function()
  vim.api.nvim_clear_autocmds({ group = codelens_group })
  vim.api.nvim_create_autocmd("BufEnter", {
    group = codelens_group,
    once = true,
    pattern = "<buffer>",
    callback = function()
      vim.lsp.codelens.refresh()
    end,
    desc = "refresh codelenses when entering buffer",
  })

  vim.api.nvim_create_autocmd({ "BufWritePost", "CursorHold" }, {
    group = codelens_group,
    pattern = "<buffer>",
    callback = function()
      vim.lsp.codelens.refresh()
    end,
    desc = "refresh codelenses when saving buffer or holding cursor",
  })
end

M.format_on_save = function(filter)
  vim.api.nvim_clear_autocmds({ group = format_group })
  vim.api.nvim_create_autocmd("BufWritePost", {
    group = format_group,
    pattern = "<buffer>",
    callback = function()
      vim.lsp.buf.format({ async = false, filter = filter })
    end,
    desc = "format text with LSP server when saving buffer",
  })
end

return M
