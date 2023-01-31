local has_toggleterm, local_toggleterm = pcall(require, "toggleterm")

if not has_toggleterm then
  return
end

local_toggleterm.setup({
  size = function(term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    end
  end,
  open_mapping = [[<A-\>]],
  hide_numbers = true,
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = "1",
  start_in_insert = true,
  insert_mappings = true,
  terminal_mappings = true,
  persist_size = false,
  direction = "horizontal",
  close_on_exit = true,
  shell = vim.o.shell,
  float_opts = {
    border = "single",
    width = function()
      return math.floor(vim.o.columns * 0.80)
    end,
    height = function()
      return math.floor(vim.o.lines * 0.90)
    end,
    winblend = 3,
    highlights = {
      border = "Normal",
      background = "Normal",
    },
  },
})
