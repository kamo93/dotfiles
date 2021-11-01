filetype plugin on

" neovim config https://neovim.io/doc/user/nvim.html
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

" my set config
set nocompatible
set number
set autoindent
set relativenumber
if exists(":ideajoin")
	set ideajoin
endif
if exists(":idearefactormode=keep")
	set idearefactormode=keep
endif
set nohls
set ignorecase
set incsearch " incremental search that show partial matches
set smartcase
set shortmess+=c " Avoid showing message extra message when using completion
set noshowmode " hide --INSERT-- 
set tabstop=2 
set softtabstop=0 noexpandtab
set shiftwidth=2
set smarttab
set smartindent
set nowrap
set scrolloff=16
set noswapfile
set nobackup
exec 'set undodir='.stdpath('config').'/undodir'
set undofile
set colorcolumn=80
set spell
set spelllang=en_us
set completeopt=menuone,noinsert,noselect
set mouse=a
set signcolumn=yes
"setlocal fo-=t fo+=croql works for split the line if its longer
set hidden " let you leave current buffer no matter is saved or not

" plugin manager
call plug#begin('~/.config/nvim/plugged')
	"color previews
	Plug 'chrisbra/Colorizer'

	" general plugins
	Plug 'itchyny/lightline.vim'
	Plug 'preservim/nerdtree'
	Plug 'tpope/vim-surround'
	Plug 'mg979/vim-visual-multi'
	Plug 'mbbill/undotree'
	Plug 'jiangmiao/auto-pairs'
	Plug 'alvan/vim-closetag'
	Plug 'preservim/nerdcommenter'

	" git 
	Plug 'tpope/vim-fugitive'
	Plug 'airblade/vim-gitgutter'

	" Neovim LSP
	Plug 'neovim/nvim-lspconfig'

	" Autocompletion
	"Plug 'nvim-lua/completion-nvim'
	Plug 'hrsh7th/cmp-nvim-lsp'
	Plug 'hrsh7th/cmp-buffer'
	Plug 'hrsh7th/cmp-path'
	Plug 'hrsh7th/cmp-cmdline'
	Plug 'hrsh7th/nvim-cmp'

	" Telescope
	Plug 'nvim-lua/popup.nvim'
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim' 

	" color theme
	Plug 'monsonjeremy/onedark.nvim'

	" Javascript
	Plug 'maxmellon/vim-jsx-pretty'
	Plug 'yuezk/vim-js'
	Plug 'dense-analysis/ale'

call plug#end()

" vim'gitguitter configure
let g:gitgutter_terminal_reports_focus=0
nmap [h <Plug>(GitGutterPrevHunk)
nmap ]h <Plug>(GitGutterNextHunk)

" autoclose tag configure
let g:closetag_xhtml_filenames = '*.jsx, *.js'
let g:closetag_xhtml_filetypes = 'xhtml,jsx'

" mapleader to space
let mapleader = " "

" remap for save save w
nnoremap <Leader>s :w<CR>

" Quickly insert an empty new line without entering insert mode
nnoremap <Leader>o o<Esc>0"_D
nnoremap <Leader>O O<Esc>0"_D

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" remap nerdtree
let NERDTreeShowHidden=1
nnoremap <Leader>n :NERDTreeFocus<CR>

" remap terminal left terminal mode
tnoremap <C-\><C-m> <C-\><C-n>
" open terminal emulator
noremap <C-t> <cmd>edit +term<CR>

" remap for easy navigation between split buffers
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

" remap for move faster between buffers
" https://stackoverflow.com/questions/5559029/quickly-switching-buffers-in-vim-normal-mode
map gn :bn<cr>
map gp :bp<cr>
map <leader>d :bd<cr>

if exists('+termguicolors')
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum]"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum]"
endif

if (has("termguicolors"))
	set termguicolors
endif

" lightline config
if !has('gui_running')
	set t_Co=256
endif

syntax on
"colorscheme gruvbox

lua << EOF
require("onedark").setup({
	hideInactiveStatusline = true,
  sidebars = {"qf", "vista_kind", "terminal", "packer"},
	commentStyle = "italic",
  keywordStyle = "NONE",
  functionStyle = "italic",
  variableStyle = "NONE"
})
EOF
" short names for the mode on the status line mode map
let g:lightline = { 
  \ 'colorscheme': 'onedark',
	\ 'mode_map': { 
		\ 'n' : 'N',
		\ 'i' : 'I',
		\ 'R' : 'R',
		\ 'v' : 'V',
		\ 'V' : 'VL',
		\ "\<C-v>": 'VB',
		\ 'c' : 'C',
		\ 's' : 'S',
		\ 'S' : 'SL',
		\ "\<C-s>": 'SB',
		\ 't': 'T',
		\ },
  \ 'active': {
  \  'left': [ ['mode', 'paste'] ,
  \            [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
	\	 'right': [['lineinfo'], ['percert'], ['filetype']]
  \ },
  \ 'component_function': {
  \  'gitbranch': 'FugitiveHead'
  \ },
	\ 'component': {
		\'filename': '%F',
		\}
  \ }

" this keep the terminal background set up
highlight Normal guibg=none

" LSP configuration
"source ~/.config/nvim/LSP/lsp-config.vim

" Use completion-nvim in every buffer
"autocmd BufEnter * lua require'completion'.on_attach()

source ~/.config/nvim/telescope.vim

let g:ale_fixers = {
			\ 'javascript': ['eslint'],
			\ 'typescript': ['eslint'],
			\}

let g:ale_sign_error = 'x'
let g:ale_sign_warning = '⚠️'
let g:ale_fix_on_save = 1

" config vim-hexokinase 
let g:Hexokinase_highlighters = ['foregroundfull']
let g:Hexokinase_optInPatterns = 'full_hex, rgb, rgba, hsl, hsla, colour_names'

" config for nvim-cmp

lua <<EOF
  -- Setup nvim-cmp.
local cmp = require'cmp'
local nvim_lsp = require('lspconfig')

cmp.setup({
	snippet = {
		expand = function(args)
			-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
			-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
			-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
			-- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
		end,
	},
	mapping = {
		['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
		['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
		['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
		['<C-y>'] = cmp.config.disable, -- If you want to remove the default `<C-y>` mapping, You can specify `cmp.config.disable` value.
		['<C-e>'] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		['<CR>'] = cmp.mapping.confirm({ select = true }),
	},
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		-- { name = 'vsnip' }, -- For vsnip users.
		-- { name = 'luasnip' }, -- For luasnip users.
		-- { name = 'ultisnips' }, -- For ultisnips users.
		-- { name = 'snippy' }, -- For snippy users.
	}, {
		{ name = 'buffer' },
	})
})

-- Use buffer source for `/`.
cmp.setup.cmdline('/', {
	sources = {
		{ name = 'buffer' }
	}
})

-- Use cmdline & path source for ':'.
cmp.setup.cmdline(':', {
	sources = cmp.config.sources({
		{ name = 'path' }
	}, {
		{ name = 'cmdline' }
	})
})

-- Setup lspconfig.
local servers = { "tsserver", "vimls" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
		capabilities = capabilitiies
  }
end
EOF
