local has_treesitter, local_treesitter = pcall(require, "nvim-treesitter.configs")

if not has_treesitter then
  return
end

local_treesitter.setup({
  ensure_installed = {
    "bash",
    "c",
    "c_sharp",
    "cpp",
    "css",
    "go",
    "hcl",
    "help",
    "java",
    "javascript",
    "jsdoc",
    "kotlin",
    "lua",
    "make",
    "markdown",
    "perl",
    "php",
    "phpdoc",
    "python",
    "query",
    "rst",
    "ruby",
    "rust",
    "scala",
    "todotxt",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "vue",
    "yaml",
    "yang",
  },
  highlight = {
    enable = true,
    use_languagetree = false,
    disable = { "json" },
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = "o",
      toggle_hl_groups = "i",
      toggle_injected_languages = "t",
      toggle_anonymous_nodes = "a",
      toggle_language_display = "I",
      focus_language = "f",
      unfocus_language = "F",
      update = "R",
      goto_node = "<cr>",
      show_help = "?",
    },
  },
})
