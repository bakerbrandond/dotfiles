set nocompatible              " be iMproved, required
filetype off                  " required

set mouse=a
set clipboard=unnamed

" for git-gutter responsiveness
set updatetime=100

set visualbell

let g:vimtex_view_method = 'zathura'

let g:lightline = {
      \ 'colorscheme': 'nord',
      \ }

"let g:tmuxline_powerline_separators = 0

let g:hexmode_patterns = '*.bin,*.hex,*.exe,*.dat,*.o'
let g:hexmode_xxd_options = '-g 1'

let g:vimade = {"normalid": '',"basefg": '',"basebg": '',"fadelevel": 0.4,"colbufsize": 30,"rowbufsize": 30,"checkinterval": 32}

let g:rainbow_active = 1

let g:hardtime_default_on = 1

"Plug 'neoclide/coc.nvim'
"Plugin 'scrooloose/syntastic'
"Plugin 'Valloric/YouCompleteMe'
"Plugin 'vim-utils/vim-man'
"Plugin 'tomtom/quickfixsigns_vim'
"Plugin 'xolox/vim-easytags'
"Plugin 'majutsushi/tagbar'
"Plugin 'kien/ctrlp.vim'
"Plugin 'tpope/vim-repeat'

" Search
set ic
set is
set hls

set number
set relativenumber

set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4
set autoindent
set smartindent
set cindent

set backspace=indent,eol,start

set tags=./tags;,tags;

syntax on
if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif

colorscheme nord

filetype plugin indent on

set hidden

" Make
map <F9> :make
map <F7> mzgg=G`z
map K <Plug>(Man)
"map <leader>k <Plug>(Man)
"map <leader>v <Plug>(Vman)
" quick fix list navigation
map <C-j> :cn<CR>
map <C-k> :cp<CR>

" toggle relative line numbers
nnoremap <F11> :set relativenumber!<CR>
" toggle absolute line numbers
nnoremap <F12> :set number!<CR>

nnoremap <silent> <C-N> :silent noh<CR>
nnoremap <leader>h <Esc>:HardTimeToggle<CR>
nnoremap <leader>. :CtrlPTag<cr>
nnoremap <silent> <Leader>b :TagbarToggle<CR>

" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>
"highlight the current line, and have the highlighting stay where it is when
"the cursor is moved
nnoremap <silent> <Leader>l ml:execute 'match Search /\%'.line('.').'l/'<CR>
set statusline+=%{fugitive#statusline()}

autocmd BufWritePre * %s/\s\+$//e

set laststatus=2
