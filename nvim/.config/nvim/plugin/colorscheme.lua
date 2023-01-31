-- highlight helper adapted from hrsh7th
local highlight = {}

highlight.keys = {
  "fg",
  "bg",
  "bold",
  "italic",
  "reverse",
  "standout",
  "underline",
  "undercurl",
  "strikethrough",
}

highlight.override = function(group, settings)
  for _, key in ipairs(highlight.keys) do
    if not settings[key] then
      local v = vim.fn.synIDattr(vim.fn.hlID(group), key)
      if key == "fg" or key == "bg" then
        local n = tonumber(v, 10)
        v = type(n) == "number" and n or v
      else
        v = v == 1
      end
      settings[key] = v == "" and "NONE" or v
    end
  end
  vim.api.nvim_set_hl(0, group, settings)
end

local colors = vim.g["dracula#palette"]
-- g:dracula#palette.fg

-- g:dracula#palette.bglighter
-- g:dracula#palette.bglight
-- g:dracula#palette.bg
-- g:dracula#palette.bgdark
-- g:dracula#palette.bgdarker

-- g:dracula#palette.comment
-- g:dracula#palette.selection
-- g:dracula#palette.subtle

-- g:dracula#palette.cyan
-- g:dracula#palette.green
-- g:dracula#palette.orange
-- g:dracula#palette.pink
-- g:dracula#palette.purple
-- g:dracula#palette.red
-- g:dracula#palette.yellow

-- the colors palette has hex strings in first index, ansi 256 in second
-- this cleans them up so we only have hex strings that can be used
for k, v in pairs(colors) do
  if type(v) == "table" then
    colors[k] = v[1]
  end
end

local dracula_customization = vim.api.nvim_create_augroup("Dracula Customization", {})

vim.api.nvim_create_autocmd("Colorscheme", {
  group = dracula_customization,
  pattern = "dracula",
  callback = function()
    highlight.override("DraculaWinSeparator", { bg = "None" })
    highlight.override("DraculaComment", { italic = 1 })
    highlight.override("LspCodeLens", { link = "DraculaCommentBold" })
    -- haven't used a server which would use this:
    -- highlight.override("LspCodeLensSeparator", { link = "DraculaRedInverse" })
    -- Telescope
    highlight.override("TelescopePromptBorder", { fg = colors.comment })
    highlight.override("TelescopeResultsBorder", { fg = colors.comment })
    highlight.override("TelescopePreviewBorder", { fg = colors.comment })
    highlight.override("TelescopeSelection", { fg = colors.fg, bg = colors.selection })
    highlight.override("TelescopeMultiSelection", { fg = colors.purple, bg = colors.selection })
    highlight.override("TelescopeNormal", { fg = colors.fg, bg = colors.bg })
    highlight.override("TelescopeMatching", { fg = colors.purple })
    highlight.override("TelescopePromptPrefix", { fg = colors.purple })
  end,
  desc = "Override dracula colorscheme defaults.",
})

vim.api.nvim_create_autocmd("user", {
  group = dracula_customization,
  pattern = "CmpReady",
  command = "runtime after/plugin/dracula.vim",
  desc = "Re-source Dracula theme when nvim-cmp is loaded.",
})

vim.cmd([[colorscheme dracula]])
