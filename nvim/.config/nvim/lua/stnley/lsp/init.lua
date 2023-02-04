local ih = require("inlay-hints")
local lspconfig = require("lspconfig")

require("stnley.lsp.diagnostic")

local autocmd = require("stnley.lsp.autocmd")
local formatters = require("stnley.lsp.efm")
local keymap = require("stnley.keymap")

local M = {}

local function disable_semantic_tokens(client)
  client.server_capabilities.semanticTokensProvider = nil
end

local function inlay_hints(client, bufnr)
  ih.on_attach(client, bufnr)
end

local function highlight_on_hover(client)
  if client.server_capabilities.documentHighlightProvider then
    autocmd.highlight_on_hover()
  end
end

local function codelens(client)
  if client.server_capabilities.codeLensProvider then
    autocmd.codelens_refresh()
  end
end

local function format_on_save(client, filter)
  if client.server_capabilities.documentFormattingProvider then
    autocmd.format_on_save(filter)
  end
end

local function lsp_keymaps(bufnr)
  local nmap = keymap.nmap
  local nnoremap = keymap.nnoremap

    -- stylua: ignore start
    nmap("<leader>gd", function() require("trouble").toggle("lsp_definitions") end,
        { desc = "LSP: [G]o to [D]efinition", buffer = bufnr })
    nmap("<leader>gD", vim.lsp.buf.declaration, { desc = "LSP: [G]o to [D]eclaration", buffer = bufnr })
    nmap("<leader>gi", vim.lsp.buf.implementation, { desc = "LSP: [G]o to [I]mplementation", buffer = bufnr })
    nmap("<leader>gs", vim.lsp.buf.signature_help, { desc = "LSP: [G]et [S]ignature help", buffer = bufnr })
    nmap("<leader>ca", vim.lsp.buf.code_action, { desc = "LSP: [C]ode [A]ction", buffer = bufnr })
    nmap("<leader>gr", function() require("telescope.builtin").lsp_references({ layout_strategy = "vertical" }) end,
        { desc = "LSP: [G]o to [R]eferences", buffer = bufnr })
    nmap("<leader>rn", vim.lsp.buf.rename, { desc = "LSP: [R]e[N]ame", buffer = bufnr })
    nmap("K", vim.lsp.buf.hover, { desc = "LSP: hover documentation", buffer = bufnr })
    nmap("<leader>td", vim.lsp.buf.type_definition, { desc = "LSP: [T]ype [D]efinition", buffer = bufnr })
    nmap("<leader>sd", vim.diagnostic.open_float, { desc = "LSP: [S]how [D]iagnostic", buffer = bufnr })
    nnoremap("<leader>q", vim.diagnostic.setloclist, { desc = "LSP: set location list from diagnostics", buffer = bufnr })
    nnoremap("[d", vim.diagnostic.goto_prev, { desc = "LSP: previous diagnostic", buffer = bufnr })
    nnoremap("]d", vim.diagnostic.goto_next, { desc = "LSP: next diagnostic", buffer = bufnr })
    nnoremap("<leader>so", function() require("symbols-outline").toggle_outline() end,
        { desc = "LSP: [S]ymbol [O]utline", buffer = bufnr })
    nnoremap("<leader>xx", function() require("trouble").toggle("workspace_diagnostics") end,
        { desc = "LSP: workspace diagnostics", buffer = bufnr })
  -- stylua: ignore end
end

M.capabilities = require("cmp_nvim_lsp").default_capabilities()

function M.on_init(client)
  client.config.flags = client.config.flags or {}
end

-- generic on_attach function that sets up standard LSP features
function M.on_attach(client, bufnr)
  format_on_save(client, function(cl)
    return not cl.config.disable_formatting
  end)

  if client.config.inlay_hints then
    inlay_hints(client, bufnr)
  end

  lsp_keymaps(bufnr)
  disable_semantic_tokens(client)
  highlight_on_hover(client)
  codelens(client)
end

-- setup LSP server with lspconfig configuration
local function setup_server(server, config)
  -- if server config defines their own on_attach, call it before common one
  if config.on_attach then
    local old_on_attach = config.on_attach
    config.on_attach = function(client, bufnr)
      old_on_attach(client, bufnr)
      M.on_attach(client, bufnr)
    end
  else
    config.on_attach = M.on_attach
  end

  config.on_init = config.on_init or M.on_init
  config.capabilities = config.capabilities or M.capabilities
  lspconfig[server].setup(config)
end

local servers = {
  bashls = {},
  dockerls = {},
  efm = {
    init_options = { documentFormatting = true },
    root_dir = vim.loop.cwd,
    filetypes = vim.tbl_keys(formatters),
    settings = {
      rootMarkers = { ".git/", "stylua.toml" },
      languages = formatters,
    },
  },
  eslint = {
    on_attach = function()
      local group = vim.api.nvim_create_augroup("eslint", {})
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = group,
        pattern = "<buffer>",
        command = "EslintFixAll",
        desc = "run eslint when saving buffer",
      })
    end,
  },
  emmet_ls = {},
  gopls = {
    disable_formatting = true,
    inlay_hints = true,
    settings = {
      gopls = {
        codelenses = { test = true },
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
      },
    },
  },
  html = { disable_formatting = true },
  jsonls = { disable_formatting = true },
  pyright = {},
  sumneko_lua = {
    disable_formatting = true,
    inlay_hints = true,
    settings = {
      Lua = {
        hint = { enable = true },
        completion = { callSnippet = "Replace" },
        runtime = { version = "LuaJIT" },
        diagnostics = { globals = { "vim" } },
        workspace = { library = vim.api.nvim_get_runtime_file("", true) },
        -- do not send telemetry data containing a randomized but unique identifier
        telemetry = { enable = false },
      },
    },
  },
  -- TODO: think that terraformls might do formatting - if so lets disable it
  terraformls = {},
  tsserver = { disable_formatting = true },
  yamlls = {},
}

do
  for server, config in pairs(servers) do
    setup_server(server, config)
  end
end

return M
