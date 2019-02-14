set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-utils/vim-man'
" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
"Plugin 'user/L9', {'name': 'newL9'}

Plugin 'bling/vim-bufferline'
Plugin 'airblade/vim-gitgutter'
"Plugin 'tomtom/quickfixsigns_vim'
Plugin 'gcmt/taboo.vim'
set sessionoptions+=tabpages,globals
"Plugin 'Valloric/YouCompleteMe'
"Plugin 'Xuyuanp/nerdtree-git-plugin'
"Plugin 'scrooloose/nerdtree'
Plugin 'xolox/vim-easytags'
"Plugin 'majutsushi/tagbar'
Plugin 'bling/vim-airline'
Plugin 'kien/ctrlp.vim'
Plugin 'majutsushi/tagbar'
"Plugin 'edkolev/promptline.vim'
"Plugin 'edkolev/tmuxline.vim'
"Plugin 'scrooloose/syntastic'
Plugin 'fidian/hexmode'
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:ctrlp_extensions = ['tag', 'buffertag'] ", 'quickfix', 'dir', 'rtscript',
"                          \ 'undo', 'line', 'changes', 'mixed', 'bookmarkdir']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:easytags_include_members = 1
Plugin 'xolox/vim-misc'
Plugin 'wikitopian/hardmode'
Plugin 'will133/vim-dirdiff'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"noremap <silent> <leader><c-l> :call quickfixsigns#RelNumbersOnce() <cr>
"autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()

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

filetype plugin indent on

set hidden

" Make
map <f9> :make
map <F7> mzgg=G`z
map K <Plug>(Man)
"map <leader>k <Plug>(Man)
"map <leader>v <Plug>(Vman)

nnoremap <silent> <C-N> :silent noh<CR>
nnoremap <leader>h <Esc>:call ToggleHardMode()<CR>
nnoremap <leader>. :CtrlPTag<cr>
nnoremap <silent> <Leader>b :TagbarToggle<CR>

colo desert
" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>
set statusline+=%{fugitive#statusline()}

autocmd BufWritePre * %s/\s\+$//e
