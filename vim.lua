--------------------------
--General editing-related config
--------------------------

--adjust the <leader> key
vim.g.mapleader = ","

--use full color space
vim.opt.termguicolors = true

--always use unix encoding
vim.opt.fileformats = "unix"

--line numbers
vim.opt.number = true

--splitting
vim.opt.splitbelow = true --put horizontal splits below
vim.opt.splitright = true --put vertical splits to the right

--tabs
vim.opt.softtabstop = 3 --number of spaces used with tab/bs
vim.opt.tabstop = 3 --display tabs with the width of 3 spaces
vim.opt.shiftwidth = 3 --indent with 3 spaces
vim.opt.expandtab = true --expand tabs into spaces
vim.opt.smarttab = true
vim.opt.autoindent = true

-- search case insensitive if term is all lowercase
vim.opt.ignorecase = true
vim.opt.smartcase = true

--scrolling
vim.opt.cursorline = true
vim.opt.scrolloff = 2 --keep 2 lines visible over/below the cursor
vim.opt.sidescrolloff = 2

--disable mouse
vim.opt.mouse=""

--do not write a backup file (does not play nicely with file watches, f.e. by Grunt)
vim.opt.writebackup = false

-- Github limits commit messages to 72 characters per line
-- vim.api.nvim_create_autocmd("BufRead,BufNewFile", {pattern = "COMMIT_EDITMSG", command = "setlocal textwidth=0"})

-- enable spell checking
vim.opt_global.spell = true

--------------------------
--command line autocompletion
--------------------------
vim.opt.wildmenu = true
vim.opt.wildmode = "longest,list"
vim.opt.wildignore = "*.a,*.o"
vim.opt.wildignore:append("*.bmp,*.gif,*.ico,*.jpg,*.png")
vim.opt.wildignore:append(".DS_Store,.git,.hg,.svn")
vim.opt.wildignore:append("*~,*.swp,*.tmp")

--------------------------
-- Overwrite built-in shotcuts
--------------------------
--disable ex mode
vim.keymap.set("n", "Q", "")
--do not overwrite the default buffer when using x
vim.keymap.set("n", "x", '"_x')


-----------------------
-- Enhanced keyboard mappings
vim.keymap.set('n', 'tc', ':tabnew<CR>')
vim.keymap.set('n', 'tp', ':tabprevious<CR>')
vim.keymap.set('n', 'tn', ':tabnext<CR>')

--------------------------
-- General, useful shortcuts
--------------------------
--normal mode: comment out word
vim.keymap.set("n", "<leader>*", "viw<esc>a*/<esc>hbi/*<esc>lel")
--normal mode: quote word in double quotes
vim.keymap.set("n", '<leader>"', 'viw<esc>a"<esc>hbi"<esc>lel')
--normal mode: quote word in single quotes
vim.keymap.set("n", "<leader>'", "viw<esc>a'<esc>hbi'<esc>lel")
--normal mode: quote word in single quotes
vim.keymap.set("n", "<leader>`", "viw<esc>a`<esc>hbi`<esc>lel")
--visual mode: wrap in double quotes
vim.keymap.set("v", '<leader>"', '<esc>`<i"<esc>`>i"<esc>')
--visual mode: wrap in single quotes
vim.keymap.set("v", "<leader>'", "<esc>`<i'<esc>`>i'<esc>")
--visual mode: wrap in single quotes
vim.keymap.set("v", "<leader>`", "<esc>`<i`<esc>`>i`<esc>")
--use jk to exit insert mode
vim.keymap.set("i", "jk", "<esc>")
--create mappings to edit the vimrc easily
vim.keymap.set("n", "<leader>ev", ":split $MYVIMRC<cr>")
vim.keymap.set("n", "<leader>sv", ":source $MYVIMRC<cr>")


--------------------------
--Set up plugin manager
--------------------------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

--------------------------
--Plugins
--------------------------

--TODO: textobj-argument
--TODO: https://github.com/skywind3000/asynctasks.vim

require("lazy").setup({
   -- Themes & general rendering
  'sjl/badwolf', -- badwolf theme
  'tomasr/molokai', -- molokai theme
  'kyazdani42/nvim-web-devicons', -- icons in Telescope
  -- Git
  'tpope/vim-fugitive',  -- all vim commands Gdiff, Gblame, ...
  'airblade/vim-gitgutter', -- shows changed lines in left column
   -- General editing/navigation
  'easymotion/vim-easymotion', -- jump to characters in file quickly
  'ntpeters/vim-better-whitespace', -- remove trailing white spaces
  'Raimondi/delimitMate', -- automatically add matchin delimiters
  'nvim-lua/plenary.nvim', -- Dependency of other plugins
  {'nvim-telescope/telescope-fzf-native.nvim', build = 'make', },
  'nvim-telescope/telescope.nvim', -- fuzzy matcher
  'nvim-telescope/telescope-ui-select.nvim', -- integration of LSP into Telescope
  'nvim-tree/nvim-tree.lua', -- file tree explorer
  'godlygeek/tabular', -- text aligning; http://media.vimcasts.org/videos/29/alignment.ogv
   -- languages/syntax highlighting
  {'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'}, -- Treesitter
  'nvim-treesitter/nvim-treesitter-context',
   -- Language server support
  'neovim/nvim-lspconfig', -- LSP config
  'rcarriga/nvim-notify', -- LSP notifications
  'hrsh7th/cmp-nvim-lsp', -- LSP source for nvim-cmp
  'hrsh7th/nvim-cmp', -- Autocompletion plugin
  'L3MON4D3/LuaSnip',
  'saadparwaiz1/cmp_luasnip',
  'stevearc/dressing.nvim', -- nicer UI for code actions; unfortunately typrhas rendering errors
  'simrat39/symbols-outline.nvim', -- symbol outline of current file
  'mfussenegger/nvim-dap', --  Debug adapter
});

vim.cmd("silent! colorscheme molokai")

-- terminal config
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

--OSCYank config
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    if vim.v.event.operator == 'y' and vim.v.event.regname == '+' then
      require('osc52').copy_register('+')
    end
  end
})

-- Easymotion
vim.keymap.set('n', 's', '<Plug>(easymotion-overwin-f2)')

vim.g.strip_whitespace_confirm = 0
vim.g.strip_whitespace_on_save = 1

--------------------------------------------
-- Nvim tree
--------------------------------------------
require("nvim-tree").setup({
  update_focused_file = {
    enable = true,
  },
  live_filter = {
    always_show_folders = false,
  }
})
vim.keymap.set("n", "<leader>t", ":NvimTreeToggle<CR>")

--------------------------------------------
-- Telescope
--------------------------------------------
local telescope = require("telescope");
local telescope_builtin = require("telescope.builtin");

-- The `<leader>f` prefix is for toplevel entry points, independent of the current buffer
-- "f" stands for "find"
vim.keymap.set('n', '<leader>f<CR>', telescope_builtin.resume)
vim.keymap.set('n', '<leader>ft', telescope_builtin.builtin)
vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files)
vim.keymap.set('n', '<leader>fg', telescope_builtin.live_grep)
vim.keymap.set('n', '<leader>fb', function()
   telescope_builtin.buffers({ sort_mru = true, ignore_current_buffer = true })
end)
vim.keymap.set('n', '<leader>fh', telescope_builtin.help_tags)
vim.keymap.set('n', '<leader>fs', telescope_builtin.lsp_dynamic_workspace_symbols)

-- Git history. `h` as in "history"
vim.keymap.set('n', '<leader>h', telescope_builtin.git_bcommits)

-- Previously opened files
-- vim.keymap.set('n', '<leader>o', telescope_builtin.old_files)


telescope.setup ({
  defaults = {
    mappings = {
      i = {
        ["<C-p>"] = require('telescope.actions').cycle_history_prev,
        ["<C-n>"] = require('telescope.actions').cycle_history_next,
      },
    },
  },
  pickers = {
    buffers = {
      mappings = {
        n = {
          ['d'] = require('telescope.actions').delete_buffer
        },
      },
    },
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_cursor({})
    }
  }
})
telescope.load_extension("ui-select")
telescope.load_extension("fzf")


--------------------------------------------
-- Notifications
--------------------------------------------
local notify = require("notify")
notify.setup({
    max_width = 80,
    max_height = 20,
    icons = {
        ERROR = "",
        WARN = "",
        INFO = "",
        DEBUG = "",
        TRACE = "✎",
    }
})
vim.notify = notify
vim.keymap.set('n', '<leader>n', require('telescope').extensions.notify.notify)


--------------------------------------------
-- Treesitter
--------------------------------------------
require('nvim-treesitter.configs').setup({
    ensure_installed = {
       -- System programming
       "c", "cpp", "rust", "proto",
        -- Web development
       "typescript", "css", "html", "sql",
       -- Scripting
       "python", "bash",
       -- Build systems
       "cmake", "starlark",
       -- Neovim itself
       "lua", "vimdoc",
       -- Text editing
       "markdown", "rst", "latex",
       -- File format
       "json", "yaml"},
    sync_install = false,
    auto_install = false,
    highlight = {
        enable = true,
    },
})

-- Use treesitter for code folding
vim.opt.foldlevelstart=999
vim.opt.foldmethod="expr"
vim.api.nvim_command("set foldexpr=nvim_treesitter#foldexpr()")


-- Use treesitter to display context
require('treesitter-context').setup{
  enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
  max_lines = 3, -- How many lines the window should span. Values <= 0 mean no limit.
  min_window_height = 6, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
  line_numbers = true,
  multiline_threshold = 1, -- Maximum number of lines to show for a single context
  trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
  mode = 'topline',  -- Line used to calculate context. Choices: 'cursor', 'topline'
}

--------------------------------------------
-- LSP support
--------------------------------------------

local cmp = require'cmp'
local nvim_lsp = require('lspconfig')

-----------------------
-- Setup nvim-cmp.
luasnip = require('luasnip')

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
    end
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
    ['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
    -- C-b (back) C-f (forward) for snippet placeholder navigation.
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
  }, {
    { name = 'buffer' },
  })
})

-----------------------
-- Shortcuts for diagnostics

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', telescope_builtin.diagnostics)

-----------------------
-- Setup lspconfig.

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local clients
     clients = vim.lsp.get_clients({
        id = ev.data.client_id
    })

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration)
    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition)
    vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references)
    vim.keymap.set('n', 'gd', require('telescope.builtin').lsp_definitions)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename)
    vim.keymap.set({'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action)
    vim.keymap.set({'n', 'v'}, '<leader>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)

    for _, client in ipairs(clients) do
       -- Inlay hints
       if client.server_capabilities.inlayHintProvider then
         vim.lsp.inlay_hint.enable(true)
         -- Allow to toggle inlay hints
         vim.keymap.set('n', '<leader>i', function ()
           vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
         end)
       end

       -- Trigger highlighting of symbol under cursor by keeping the cursor still
       if client.server_capabilities.documentHighlightProvider then
         vim.api.nvim_create_autocmd('CursorHold', { callback = vim.lsp.buf.document_highlight})
         vim.api.nvim_create_autocmd('CursorHoldI', { callback = vim.lsp.buf.document_highlight})
         vim.api.nvim_create_autocmd('CursorMoved', { callback = vim.lsp.buf.clear_references})
       end

       -- clangd-specific key bindings
       if client.name == "clangd" then
         vim.keymap.set('n', 'g<Tab>', "<cmd>ClangdSwitchSourceHeader<CR>")
       end
   end
  end
})

vim.lsp.set_log_level("warn")

nvim_lsp["clangd"].setup {
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
  filetypes = {'c', 'cpp', 'objc', 'objcpp', 'cuda'},
  -- to debug: '-log:verbose'
  -- --hidden-features
  --cmd = { '/usr/lib/llvm-17/bin/clangd', '--enable-config', '--use-dirty-headers', '--limit-references=10000', '--limit-results=10000', '--hidden-features'},
  cmd = { 'clangd', '--enable-config', '--limit-references=10000', '--limit-results=10000', '--parse-forwarding-functions'},
  flags = {
    debounce_text_changes = 300,
  }
}

vim.lsp.handlers['window/showMessage'] = function(_, result, ctx)
  local clients
  clients = vim.lsp.get_clients({
     id = ctx.client_id
  })
  local lvl = ({
    'ERROR',
    'WARN',
    'INFO',
    'DEBUG',
  })[result.type]

  for _, client in ipairs(clients) do
     vim.notify(result.message, lvl, {
       title = 'LSP | ' .. client.name,
       timeout = 10000,
       keep = function()
         return lvl == 'ERROR' or lvl == 'WARN'
       end,
     })
  end
end


-- LSP progress notifications
-- based on https://github.com/rcarriga/nvim-notify/issues/43#issuecomment-1030604806
local client_notifs = {}

local function get_notif_data(client_id, token)
  if not client_notifs[client_id] then
    client_notifs[client_id] = {}
  end

  if not client_notifs[client_id][token] then
    client_notifs[client_id][token] = {}
  end

  return client_notifs[client_id][token]
end


local spinner_frames = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" }

local function update_spinner(client_id, token)
  local notif_data = get_notif_data(client_id, token)

  if notif_data.spinner then
    local new_spinner = (notif_data.spinner + 1) % #spinner_frames
    notif_data.spinner = new_spinner

    notif_data.notification = vim.notify(nil, nil, {
      hide_from_history = true,
      icon = spinner_frames[new_spinner],
      replace = notif_data.notification,
    })

    vim.defer_fn(function()
      update_spinner(client_id, token)
    end, 100)
  end
end

local function format_title(title, client_name)
  return client_name .. (#title > 0 and ": " .. title or "")
end

local function format_message(message, percentage)
  return (percentage and percentage .. "%\t" or "") .. (message or "")
end

vim.lsp.handlers["$/progress"] = function(_, result, ctx)
  local client_id = ctx.client_id
  local val = result.value

  if not val.kind then
    return
  end

  local notif_data = get_notif_data(client_id, result.token)

  if val.kind == "begin" then
    local message = format_message(val.message, val.percentage)

    notif_data.notification = vim.notify(message, "info", {
      title = format_title(val.title, client_id),
      icon = spinner_frames[1],
      timeout = false,
      hide_from_history = false,
    })

    notif_data.spinner = 1
    update_spinner(client_id, result.token)
  elseif val.kind == "report" and notif_data then
    notif_data.notification = vim.notify(format_message(val.message, val.percentage), "info", {
      replace = notif_data.notification,
      hide_from_history = false,
    })
  elseif val.kind == "end" and notif_data then
    notif_data.notification =
      vim.notify(val.message and format_message(val.message) or "Complete", "info", {
        icon = "",
        replace = notif_data.notification,
        timeout = 3000,
      })

    notif_data.spinner = nil
  end
end

-- Symbols outline
require("symbols-outline").setup()
vim.keymap.set('n', '<leader>s', "<cmd>SymbolsOutline<cr>")

