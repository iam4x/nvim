local group = vim.api.nvim_create_augroup("user_config", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.wrap = true
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = "gitcommit",
  callback = function()
    vim.opt_local.textwidth = 72
    vim.opt_local.colorcolumn = "73"
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = group,
  callback = function()
    vim.highlight.on_yank({ timeout = 150 })
  end,
})
