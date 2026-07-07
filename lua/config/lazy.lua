local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  local result = vim.system({ "git", "clone", "--filter=blob:none", "--branch=stable", repo, lazypath }):wait()
  if result.code ~= 0 then
    error("Failed to install lazy.nvim:\n" .. result.stderr)
  end
end
vim.opt.rtp:prepend(lazypath)

local treesitter_languages = {
  "bash",
  "css",
  "diff",
  "git_config",
  "git_rebase",
  "gitattributes",
  "gitcommit",
  "gitignore",
  "html",
  "javascript",
  "jsdoc",
  "json",
  "json5",
  "lua",
  "luadoc",
  "markdown",
  "markdown_inline",
  "regex",
  "toml",
  "tsx",
  "typescript",
  "vim",
  "vimdoc",
  "yaml",
}

require("lazy").setup({
  {
    "Mofiqul/vscode.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "dark",
      transparent = true,
    },
    config = function(_, opts)
      require("vscode").setup(opts)
      vim.cmd.colorscheme("vscode")
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = function()
      if vim.fn.executable("tree-sitter") == 0 then
        vim.notify("nvim-treesitter parser updates require the tree-sitter CLI", vim.log.levels.WARN)
        return
      end

      local treesitter = require("nvim-treesitter")
      if type(treesitter.install) == "function" then
        treesitter.install(treesitter_languages):wait(300000)
      else
        vim.cmd.TSUpdate()
      end
    end,
    config = function()
      local treesitter = require("nvim-treesitter")

      if type(treesitter.install) ~= "function" then
        require("nvim-treesitter.configs").setup({
          ensure_installed = treesitter_languages,
          highlight = { enable = true },
          indent = { enable = true },
        })
        return
      end

      vim.treesitter.language.register("json", "jsonc")

      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "bash",
          "css",
          "diff",
          "gitattributes",
          "gitcommit",
          "gitconfig",
          "gitignore",
          "html",
          "javascript",
          "javascriptreact",
          "json",
          "json5",
          "jsonc",
          "lua",
          "markdown",
          "sh",
          "toml",
          "typescript",
          "typescriptreact",
          "vim",
          "vimdoc",
          "yaml",
        },
        callback = function(args)
          pcall(vim.treesitter.start, args.buf)
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },

  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    opts = {
      ui = { border = "rounded" },
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      vim.lsp.config("yamlls", {
        filetypes = { "yaml" },
      })

      vim.diagnostic.config({
        severity_sort = true,
        virtual_text = { spacing = 2, prefix = ">" },
        float = { border = "rounded", source = true },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "E",
            [vim.diagnostic.severity.WARN] = "W",
            [vim.diagnostic.severity.INFO] = "I",
            [vim.diagnostic.severity.HINT] = "H",
          },
        },
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      ensure_installed = {
        "bashls",
        "jsonls",
        "lua_ls",
        "taplo",
        "ts_ls",
        "yamlls",
      },
      automatic_enable = true,
    },
  },

  {
    "stevearc/conform.nvim",
    event = { "BufWritePre", "BufNewFile" },
    opts = {
      format_on_save = function(bufnr)
        local disabled = { gitcommit = true }
        if disabled[vim.bo[bufnr].filetype] then
          return nil
        end
        return { timeout_ms = 1000, lsp_format = "fallback" }
      end,
      formatters_by_ft = {
        javascript = { "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "prettierd", "prettier", stop_after_first = true },
        json = { "prettierd", "prettier", stop_after_first = true },
        jsonc = { "prettierd", "prettier", stop_after_first = true },
        lua = { "stylua" },
        markdown = { "prettierd", "prettier", stop_after_first = true },
        toml = { "taplo" },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },
        yaml = { "prettierd", "prettier", stop_after_first = true },
      },
    },
  },

  {
    "saghen/blink.cmp",
    version = "1.*",
    event = "InsertEnter",
    opts = {
      keymap = { preset = "default" },
      appearance = { nerd_font_variant = "mono" },
      completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 300 },
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
    },
  },

  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      current_line_blame_opts = { delay = 500 },
    },
  },
  {
    "kdheepak/lazygit.nvim",
    cmd = "LazyGit",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      winopts = { border = "rounded" },
      files = { git_icons = true },
      grep = { rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096" },
    },
  },
  {
    "stevearc/oil.nvim",
    lazy = false,
    keys = { { "<leader>e", "<cmd>Oil<cr>", desc = "Open file explorer" } },
    opts = {
      default_file_explorer = true,
      view_options = { show_hidden = true },
      columns = { "icon" },
    },
  },

  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    opts = {},
  },
  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    opts = {},
  },
  {
    "echasnovski/mini.pairs",
    event = "InsertEnter",
    opts = {},
  },
  {
    "echasnovski/mini.surround",
    event = "VeryLazy",
    opts = {},
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
  },
}, {
  install = { colorscheme = { "vscode" } },
  rocks = { enabled = false },
  checker = { enabled = true, notify = false },
  change_detection = { notify = false },
})
