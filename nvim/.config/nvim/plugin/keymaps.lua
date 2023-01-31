local keymap = require("stnley.keymap")

local map = keymap.map
local inoremap = keymap.inoremap
local nnoremap = keymap.nnoremap
local tnoremap = keymap.tnoremap
local vnoremap = keymap.vnoremap

-- stylua: ignore start

-- greatest remap ever
vnoremap("<leader>p", '"_dp')

-- next greatest remap ever : asbjornHaland
nnoremap("<leader>y", '"+y')
vnoremap("<leader>y", '"+y')

nnoremap("<leader>d", '"_d')
vnoremap("<leader>d", '"_d')

-- move lines
nnoremap("<C-j>", ":m .+1<CR>==", { silent = true })
nnoremap("<C-k>", ":m .-2<CR>==", { silent = true })

inoremap("<C-j>", "<Esc>:m .+1<CR>==gi", { silent = true })
inoremap("<C-k>", "<Esc>:m .-2<CR>==gi", { silent = true })

vnoremap("<C-j>", ":m '>+1<CR>gv=gv", { silent = true })
vnoremap("<C-k>", ":m '<-2<CR>gv=gv", { silent = true })

-- terminal
tnoremap("<Esc>", [[<C-\><C-n>]], { silent = true })
tnoremap("<C-h>", [[<C-\><C-n><C-w>h]], { silent = true })
tnoremap("<C-j>", [[<C-\><C-n><C-w>j]], { silent = true })
tnoremap("<C-k>", [[<C-\><C-n><C-w>k]], { silent = true })
tnoremap("<C-l>", [[<C-\><C-n><C-w>l]], { silent = true })

--
-- plugin specific
--

-- telescope
nnoremap("<leader>ff", function() require("telescope.builtin").find_files() end, { desc = "Telescope: [F]ind [F]iles" })
nnoremap("<leader>fg", function() require('telescope.builtin').live_grep() end, { desc = "Telescope: [F]ind with [G]rep" })
nnoremap("<leader>/", function() require('telescope.builtin').current_buffer_fuzzy_find() end, { desc = "Telescope: fuzzy find current buffer" })
nnoremap("<C-p>", function() require('telescope').extensions.file_browser.file_browser() end, { desc = "Telescope: browse files" })
nnoremap("<leader>fb", function() require('telescope.builtin').buffers() end, { desc = "Telescope: [F]ind [B]uffers" })
nnoremap("<leader>fh", function() require('telescope.builtin').find_files({ hidden=true }) end, { desc = "Telescope: [F]ind [H]idden" })
nnoremap("<leader>ht", function() require('telescope.builtin').help_tags() end, { desc = "Telescope: [H]elp [T]ags" })

-- hop
map("<C-f>", function() require("hop").hint_words() end, { desc = "Hop: move wordwise" })
map("t", function() require("hop").hint_char1() end, { desc = "Hop: move 1 charwise" })
map("T", function() require("hop").hint_char2() end, { desc = "Hop: move 2 charwise" })

-- gitsigns
map("<leader>hp", function() require("gitsigns").preview_hunk() end, { desc = "Git: [H]unk [P]review" })
map("<leader>hs", function() require("gitsigns").stage_hunk() end, { desc = "Git: [H]unk [S]tage" })
map("<leader>hr", function() require("gitsigns").reset_hunk() end, { desc = "Git: [H]unk [R]eset" })
map("<leader>hd", function() require("gitsigns").diffthis() end, { desc = "Git: [H]unk [D]iff" })
map("<leader>hN", function() require("gitsigns").prev_hunk() end, { desc = "Git: hunk prev" })
map("<leader>hn", function() require("gitsigns").next_hunk() end, { desc = "Git: [H]unk [N]ext" })
-- TODO: conflicts with lsp map
-- map("<leader>td", function() require("gitsigns").toggle_deleted() end, { desc = "Git: [T]oggle [D]eleted" })

-- todo-comments
nnoremap("<leader>xt", function() require("trouble").toggle("todo") end, { desc = "Todo: toggle workspace to-dos" })

-- zen mode
nnoremap("<leader>z", function() require("zen-mode").toggle() end, { desc = "Zen: [Z]en mode" })

-- toggleterm
map([[<A-\>]], "<cmd>ToggleTerm<CR>", { desc = "Terminal: toggle horizontal terminal" })
nnoremap("<leader>tt", "<cmd>ToggleTerm direction=float<CR>", { desc = "Terminal: toggle pop up terminal" })

-- debugging
nnoremap("<F1>", function() require('dap').step_back() end, { desc = "DAP: step back" })
nnoremap("<F2>", function() require('dap').step_into() end, { desc = "DAP: step into" })
nnoremap("<F3>", function() require('dap').step_over() end, { desc = "DAP: step over" })
nnoremap("<F4>", function() require('dap').step_out() end, { desc = "DAP: step out" })
nnoremap("<F5>", function() require('dap').continue() end, { desc = "DAP: continue" })
nnoremap("<F12>", function() require('dap').terminate() end, { desc = "DAP: terminate session" })
nnoremap("<leader>b", function() require('dap').toggle_breakpoint() end, { desc = "DAP: [B]reakpoint" })
nnoremap("<leader>B", function() vim.ui.input({ prompt = "Breakpoint condition: " }, function(input) require("dap").set_breakpoint(input) end) end, { desc = "DAP: [B]reakpoint with condition" })
nnoremap("<leader>lp", function() vim.ui.input({ prompt = "Log point message: " }, function(input) require('dap').set_breakpoint(nil, nil, input) end) end, { desc = "DAP: [L]og [P]oint" })
nnoremap("<leader>dr", function() require('dap').repl.open() end, { desc = "DAP: [D]ebug [R]EPL" })
nnoremap("<leader>dl", function() require('dap').run_last() end, { desc = "DAP: [D]ebug [L]ast" })

-- stylua: ignore end
