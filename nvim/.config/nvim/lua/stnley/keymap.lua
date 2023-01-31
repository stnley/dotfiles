local M = {}

local function keymap(mode, outer_opts)
  outer_opts = outer_opts or { noremap = true }
  return function(lhs, rhs, opts)
    opts = vim.tbl_extend("force", outer_opts, opts or {})
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

M.map = keymap("")
M.nmap = keymap("n", { noremap = false })
M.nnoremap = keymap("n")
M.inoremap = keymap("i")
M.tnoremap = keymap("t")
M.vnoremap = keymap("v")

return M
