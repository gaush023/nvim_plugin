call plug#begin('~/.local/share/nvim/plugged')

" Set leader to space
let mapleader = " "

Plug 'github/copilot.vim'  
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.6' }
Plug 'akinsho/bufferline.nvim', { 'tag': '*' }
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'nvim-lualine/lualine.nvim'
Plug 'vim-airline/vim-airline'

call plug#end()

set number
colorscheme dracula

" Nvim-tree settings
nnoremap <C-n> :NvimTreeToggle<CR>  " Ctrl-n to toggle Nvim Tree

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>


lua << EOF

require('lualine').setup{
    options = {
    -- ...
    theme = 'dracula-nvim'
    -- ...
  }
}


local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      -- For `vsnip` users.
      vim.fn["vsnip#anonymous"](args.body) 
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'buffer' },
  })
})

require("bufferline").setup{
   options = {
     separator_style = "thin",
     diagnostics = "nvim_lsp",
     diagnostics_indicator = function(count, level, diagnostics_dict, context)
       local icon = level:match("error") and " " or " "
       return " " .. icon .. count
     end,
   }
}
require'nvim-tree'.setup {
   disable_netrw       = true,
   hijack_netrw        = true,
   hijack_cursor       = false,
   update_cwd          = true,
   diagnostics = {
     enable = true,
     icons = {
       hint = "",
       info = "",
       warning = "",
       error = "",
     },
   },
   update_focused_file = {
     enable      = true,
     update_cwd  = true,
   },
   filters = {
     dotfiles = false,
     custom = {}
   },
   git = {
     enable = true,
     ignore = true,
     timeout = 500,
   },
   view = {
     width = 30,
     side = 'left',
     adaptive_size = true
   },
   renderer = {
     highlight_git = true,
     highlight_opened_files = "icon",
     root_folder_modifier = ":~",
     indent_markers = {
       enable = true,
     },
     icons = {
       glyphs = {
         default = "",
         symlink = "",
         folder = {
           arrow_closed = "",
           arrow_open = "",
           default = "",
           open = "",
           empty = "",
           empty_open = "",
           symlink = "",
           symlink_open = "",
         },
         git = {
           unstaged = "✗",
           staged = "✓",
           unmerged = "",
           renamed = "➜",
           untracked = "★",
           deleted = "",
           ignored = "◌"
         }
       }
     }
   }
}
EOF

