vim.g.mapleader = [[ ]] -- <Space>

-- bootstrap plugin manager
local ensure_packer = function()
  local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"
  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    local out =
      vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    print(out)
    print("Downloading packer.nvim...")
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()
if packer_bootstrap then
  require("stnley.packer")
  print("To install plugins, run ':PackerSync'")
  print("(you will need to restart)")
  return
end

-- disable built-in plugins
vim.g.loaded_gzip = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
