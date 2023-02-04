local M = {}

local stylua = {
  formatCommand = "stylua -",
  formatStdin = true,
}

local black = {
  formatCommand = "black -",
  formatStdin = true,
}

local isort = {
  formatCommand = "isort --stdout --profile black -",
  formatStdin = true,
}

local flake8 = {
  lintCommand = "flake8 --format '%(path)s:%(row)d:%(col)d: %(code)s %(code)s %(text)s' --stdin-display-name ${INPUT} -",
  lintStdin = true,
  lintIgnoreExitCode = true,
  lintFormats = { "%f:%l:%c: %t%n%n%n %m" },
  lintSource = "flake8",
}

local mypy = {
  lintCommand = "mypy --show-column-numbers --ignore-missing-imports",
  lintFormats = {
    "%f:%l:%c: %trror: %m",
    "%f:%l:%c: %tarning: %m",
    "%f:%l:%c: %tote: %m",
  },
  lintSource = "mypy",
}

local shellcheck = {
  lintCommand = "shellcheck -f gcc -x -",
  lintStdin = true,
  lintFormats = { "%f:%l:%c: %trror: %m", "%f:%l:%c: %tarning: %m", "%f:%l:%c: %tote: %m" },
  lintSource = "shellcheck",
}

local shfmt = {
  formatCommand = "shfmt ${-i:tabWidth}",
}

local terraform = {
  formatCommand = "terraform fmt -",
  formatStdin = true,
}

local prettier = {
  formatCommand = ([[
    $([ -n "$(command -v node_modules/.bin/prettier)" ] && echo "node_modules/.bin/prettier" || echo "prettier")
    ${--config-precedence:configPrecedence}
    ${--tab-width:tabWidth}
    ${--trailing-comma:trailingComma}
  ]]):gsub("\n", ""),
}

local govet = {
  lintCommand = "go vet",
  lintIgnoreExitCode = true,
  lintFormats = { "%f:%l:%c: %m" },
  lintSource = "go vet",
}

-- formats imports as well as code with 'gofmt'
local goimports = {
  formatCommand = "goimports",
  formatStdin = true,
}

-- 3 diagnostics per error kinda sucks
local staticcheck = {
  lintCommand = "staticcheck -f text ${INPUT}",
  lintIgnoreExitCode = true,
  lintFormats = { "%f:%l:%c: %m" },
  lintSource = "staticcheck",
}

local google_java_format = {
  formatCommand = "google-java-format -",
  formatStdin = true,
}

-- TODO: can this be made dynamic?
-- check to see if checkstyle config exists, then fallback to google?
-- create input, get path for checkstyle config (complete w paths from cwd)
local checkstyle = {
  lintCommand = "checkstyle -c google_checks.xml ${INPUT}",
  lintIgnoreExitCode = true,
  lintFormats = {
    "[%tRROR]\\ %f:%l:%c:\\ %m",
    "[%tRROR]\\ %f:%l:\\ %m",
    "[%tARN]\\ %f:%l:%c:\\ %m",
    "[%tARN]\\ %f:%l:\\ %m",
  },
  lintSource = "checkstyle",
}

M.java = { google_java_format, checkstyle }
M.json = { prettier }
M.jsonc = { prettier }
M.lua = { stylua }
M.python = { black, isort, flake8, mypy }
M.sh = { shellcheck, shfmt }
M.terraform = { terraform }
M.yaml = { prettier }
M.go = { govet, goimports }

return M
