set hidden

"help highlighting
set conceallevel=0
hi link HelpBar Normal
hi link HelpStar Normal

autocmd FileType gitcommit setlocal spell
set nocompatible
" fix weird 2;2R3;1R issue
set t_u7=

let mapleader = ","

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'
Plug 'github/copilot.vim'
"Plug 'dense-analysis/ale'
"Plug 'leafgarland/typescript-vim'
"Plug 'moll/vim-node'

"Plug 'vivien/vim-linux-coding-style'
"Plug '8ooo8/leetcode'
"Plug 'numToStr/FTerm.nvim'
"Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}
Plug 'BourgeoisBear/vim-rsvp'
Plug 'ubaldot/vim-writegood'
"Plug 'vimpostor/vim-tpipeline'
Plug 'dpelle/vim-LanguageTool'
Plug 'ron89/thesaurus_query.vim'
Plug 'mhinz/vim-startify'

Plug 'lervag/vimtex'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/goyo.vim'
Plug 'sotte/presenting.vim'
Plug 'nanotee/zoxide.vim'
Plug 'jparise/vim-graphql'

Plug 'luochen1990/rainbow'
"Plug 'frazrepo/vim-rainbow'

Plug 'edkolev/tmuxline.vim'

Plug 'itchyny/lightline.vim'

Plug 'sheerun/vim-polyglot'

Plug 'nordtheme/vim'
" Make sure you use single quotes
" Use release branch (recommended)
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jayli/vim-easycomplete'

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Multiple Plug commands can be written in a single line using | separators
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
Plug 'preservim/NERDTree', { 'on': 'NERDTreeToggle' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using a non-default branch
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
Plug 'fatih/vim-go', { 'tag': '*' }

" Plugin options
Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Unmanaged plugin (manually installed and updated)
Plug '~/my-prototype-plugin'

Plug 'ryanoasis/vim-devicons'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-dadbod'

Plug 'airblade/vim-gitgutter'

Plug 'preservim/NERDTree'

" Initialize plugin system
" - Automatically executes `filetype plugin indent on` and `syntax enable`.
call plug#end()
" You can revert the settings after the call like so:
"   filetype indent off   " Disable file-type-specific indentation
"   syntax off            " Disable syntax highlighting

let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle

" CoC extensions
"let g:coc_global_extensions = [ 'coc-json', 'coc-tsserver', 'coc-sh', 'coc-clangd', 'coc-pyright', 'coc-go', 'coc-css', 'coc-html' ]


" Source Vim configuration file and install plugins
nnoremap <silent><leader>1 :source ~/.vimrc \| :PlugInstall<CR>

set encoding=UTF-8
colorscheme nord


" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" This is necessary for VimTeX to load properly. The "indent" is optional.
" Note that most plugin managers will do this automatically.
filetype plugin indent on

" This enables Vim's and neovim's syntax-related features. Without this, some
" VimTeX features will not work (see ":help vimtex-requirements" for more
" info).
syntax enable

" Viewer options: One may configure the viewer either by specifying a built-in
" viewer method:
let g:vimtex_view_method = 'zathura'

" Or with a generic interface:
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'

" VimTeX uses latexmk as the default compiler backend. If you use it, which is
" strongly recommended, you probably don't need to configure anything. If you
" want another compiler backend, you can change it as follows. The list of
" supported backends and further explanation is provided in the documentation,
" see ":help vimtex-compiler".
let g:vimtex_compiler_method = 'latexrun'

" Most VimTeX mappings rely on localleader and this can be changed with the
" following line. The default is usually fine and is the symbol "\".
let maplocalleader = ","

let g:limelight_conceal_ctermfg = 'gray'
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
