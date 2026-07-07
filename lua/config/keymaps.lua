local map = vim.keymap.set

map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })
map("n", "<leader>w", "<cmd>write<cr>", { desc = "Write file" })
map("n", "<leader>q", "<cmd>quit<cr>", { desc = "Quit window" })
map("n", "<leader>x", "<cmd>source %<cr>", { desc = "Source current file" })

map("n", "<leader>e", "<cmd>Oil<cr>", { desc = "Open file explorer" })
map("n", "<leader>ff", "<cmd>FzfLua files<cr>", { desc = "Find files" })
map("n", "<leader>fg", "<cmd>FzfLua live_grep<cr>", { desc = "Live grep" })
map("n", "<leader>fb", "<cmd>FzfLua buffers<cr>", { desc = "Find buffers" })
map("n", "<leader>fh", "<cmd>FzfLua help_tags<cr>", { desc = "Find help" })

map("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "Open lazygit" })
map("n", "<leader>gb", "<cmd>Gitsigns blame_line<cr>", { desc = "Git blame line" })
map("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", { desc = "Preview git hunk" })
map("n", "]h", "<cmd>Gitsigns next_hunk<cr>", { desc = "Next git hunk" })
map("n", "[h", "<cmd>Gitsigns prev_hunk<cr>", { desc = "Previous git hunk" })

map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
map("n", "gr", vim.lsp.buf.references, { desc = "Find references" })
map("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
map("n", "<leader>f", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format buffer" })

map("n", "<leader>dd", vim.diagnostic.open_float, { desc = "Line diagnostics" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
