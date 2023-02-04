local has_cmp, local_cmp = pcall(require, "cmp")

if not has_cmp then
  return
end

local snippy = require("snippy")

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp_kinds = {
  Text = " ",
  Method = " ",
  Function = " ",
  Constructor = " ",
  Field = "ﰠ ",
  Variable = " ",
  Class = "ﴯ ",
  Interface = " ",
  Module = " ",
  Property = "ﰠ ",
  Unit = "塞",
  Value = " ",
  Enum = " ",
  Keyword = " ",
  Snippet = " ",
  Color = " ",
  File = " ",
  Reference = " ",
  Folder = " ",
  EnumMember = " ",
  Constant = " ",
  Struct = "פּ ",
  Event = " ",
  Operator = " ",
  TypeParameter = "  ",
}

local_cmp.setup({
  snippet = {
    expand = function(args)
      snippy.expand_snippet(args.body)
    end,
  },
  mapping = {
    ["<C-d>"] = local_cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = local_cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = local_cmp.mapping.complete(),
    ["<C-e>"] = local_cmp.mapping.abort(),
    ["<CR>"] = local_cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = local_cmp.mapping(function(fallback)
      if local_cmp.visible() then
        local_cmp.select_next_item()
      elseif snippy.can_expand_or_advance() then
        snippy.expand_or_advance()
      elseif has_words_before() then
        local_cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<C-n>"] = local_cmp.mapping.select_next_item(),
    ["<S-Tab>"] = local_cmp.mapping(function(fallback)
      if local_cmp.visible() then
        local_cmp.select_prev_item()
      elseif snippy.can_jump(-1) then
        snippy.previous()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<C-p>"] = local_cmp.mapping.select_prev_item(),
    ["<C-y>"] = local_cmp.mapping.confirm({ select = false }),
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "nvim_lsp_signature_help" },
    { name = "snippy" },
    { name = "buffer" },
    { name = "path" },
  },
  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = (cmp_kinds[vim_item.kind] or "") .. vim_item.kind
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        nvim_lua = "[Lua]",
        snippy = "[Snippy]",
        buffer = "[Buffer]",
      })[entry.source.name]
      return vim_item
    end,
  },
  enabled = function()
    local context = require("cmp.config.context")

    local disabled = false
    disabled = disabled or (vim.api.nvim_buf_get_option(0, "buftype") == "prompt")
    disabled = disabled or (vim.fn.reg_recording() ~= "")
    disabled = disabled or (vim.fn.reg_executing() ~= "")
    disabled = disabled or context.in_treesitter_capture("comment")
    disabled = disabled or context.in_syntax_group("Comment")
    return not disabled
  end,
  experimental = {
    ghost_text = true,
  },
})

local_cmp.setup.cmdline("/", {
  mapping = local_cmp.mapping.preset.cmdline(),
  sources = local_cmp.config.sources({
    { name = "nvim_lsp_document_symbol" },
    { name = "buffer" },
  }),
})

local_cmp.setup.cmdline(":", {
  mapping = local_cmp.mapping.preset.cmdline(),
  sources = local_cmp.config.sources({
    { name = "path" },
    { name = "cmdline" },
  }),
})
