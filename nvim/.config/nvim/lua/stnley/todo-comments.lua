local has_tc, local_tc = pcall(require, "todo-comments")

if not has_tc then
  return
end

local_tc.setup({
  keywords = {
    NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
  },
  highlight = {
    -- match "PATTERN:" or "PATTERN (<any chars>):"
    pattern = { [[.*<(KEYWORDS)\s*:]], [[.*<(KEYWORDS)\s[(]\S*[)]:]] },
  },
  colors = {
    hint = { "Search" },
  },
})

-- keywords:
-- PERF:
-- HACK:
-- TODO:
-- NOTE:
-- FIX:
-- WARNING:

-- additional pattern matching:
-- NOTE : this works

-- NOTE  : this also works

--NOTE (stnley): this lets me use parenthesis hints

--NOTE    (stnley): but not with more than 1 space
