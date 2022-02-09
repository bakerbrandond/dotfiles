set nocompatible              " be iMproved, required
filetype off                  " required

set visualbell

" let Vundle manage Vundle, required
"Plugin 'VundleVim/Vundle.vim'
"Plugin 'vim-utils/vim-man'
" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
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

"Plugin 'jeffkreeftmeijer/vim-numbertoggle'
"Plugin 'bling/vim-bufferline'
"Plugin 'airblade/vim-gitgutter'
"Plugin 'tomtom/quickfixsigns_vim'
"Plugin 'gcmt/taboo.vim'
set sessionoptions+=tabpages,globals
"Plugin 'Valloric/YouCompleteMe'
"Plugin 'Xuyuanp/nerdtree-git-plugin'
"Plugin 'scrooloose/nerdtree'
"Plugin 'xolox/vim-easytags'
"Plugin 'majutsushi/tagbar'
"Plugin 'vim-airline/vim-airline'
"Plugin 'vim-airline/vim-airline-themes'
"let g:airline_theme='badwolf'
"Plugin 'edkolev/tmuxline.vim'
"let g:tmuxline_powerline_separators = 0
"Plugin 'kien/ctrlp.vim'
"Plugin 'majutsushi/tagbar'
"Plugin 'edkolev/promptline.vim'
"Plugin 'edkolev/tmuxline.vim'
"Plugin 'scrooloose/syntastic'
"Plugin 'fidian/hexmode'
"Plugin 'navicore/vissort.vim'
"Plugin 'stephpy/vim-yaml'
"Vim8+?
"Plugin 'TaDaa/vimade'
"let g:vimade = {"normalid": '',"basefg": '',"basebg": '',"fadelevel": 0.4,"colbufsize": 30,"rowbufsize": 30,"checkinterval": 32}
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
" colorized bracket pairs
"Plugin 'frazrepo/vim-rainbow'
"au FileType c,cpp,objc,objcpp call rainbow#load()
"let g:rainbow_active = 1
"Plugin 'Mcmartelle/vim-monokai-bold'
"Plugin 'altercation/vim-colors-solarized'
"Plugin 'jceb/vim-orgmode'
"Plugin 'inkarkat/vim-SyntaxRange'
"Plugin 'mattn/calendar-vim'
"Plugin 'chrisbra/NrrwRgn'
"Plugin 'tpope/vim-speeddating'
"Plugin 'vim-scripts/utl.vim'
"Plugin 'tpope/vim-repeat'
"Plugin 'vim-syntastic/syntastic.git'
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

"let g:ctrlp_extensions = ['tag', 'buffertag'] ", 'quickfix', 'dir', 'rtscript',
"                          \ 'undo', 'line', 'changes', 'mixed', 'bookmarkdir']
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"let g:easytags_include_members = 1
"Plugin 'xolox/vim-misc'
"Plugin 'takac/vim-hardtime'
"Plugin 'will133/vim-dirdiff'

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

syntax enable
syntax on
"colorscheme solarized
"colorscheme monokai-bold
colo desert
set background=dark

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

" stolen from
" https://jeffkreeftmeijer.com/vim-number/
" https://github.com/jeffkreeftmeijer/vim-numbertoggle/blob/master/plugin/number_toggle.vim
" dunno why Plugin doesn't work...
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu | set rnu   | endif
    autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu | set nornu | endif
augroup END
