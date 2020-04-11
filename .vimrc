
" SOURCE -- https://mislav.net/2011/12/vim-revisited/ --
set nocompatible 			" choose no compatibility with legacy vi
syntax enable
set encoding=utf-8
set showcmd				" display incomplete commands

filetype off


" Load Plugins here
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
" Terminator terminal specific -- https://github.com/egel/terminator-gruvbox -"
Plugin 'morhetz/gruvbox'
Plugin 'vim-airline/vim-airline'
Plugin 'mbbill/undotree'
Plugin 'lyuts/vim-rtags'
Plugin 'jacoborus/tender.vim'
Plugin 'leafgarland/typescript-vim'
Plugin 'tpope/vim-fugitive'
Plugin 'git@github.com:Valloric/YouCompleteMe.git'
Plugin 'git@github.com:ajh17/VimCompletesMe.git'
Plugin 'hotoo/jsgf.vim'
Plugin 'vim-utils/vim-man'

" Node.js plugin "
" https://github.com/moll/vim-node "
Plugin 'git@github.com:moll/vim-node.git'

" Plugin that uses AG to search "
" https://github.com/rking/ag.vim "
Plugin 'git@github.com:rking/ag.vim.git'

" Fuzzy search files "
" https://github.com/ctrlpvim/ctrlp.vim "
Plugin 'git@github.com:ctrlpvim/ctrlp.vim'

" Search pattern matcher "
" https://github.com/jremmen/vim-ripgrep "
Plugin 'jremmen/vim-ripgrep'


"If at any point I want to start learning Go, might use the below plugin "
" Plugin 'fatih/vim-go' "

" Java plugin that might be ok to test out later on... "
" Plugin 'artur-shaik/vim-javacomplete2' "

call vundle#end()

filetype plugin indent on		" load file type plugins + indentation

" Color scheme

colorscheme gruvbox
set background=dark
set tabstop=4
set shiftwidth=4
set expandtab
set rnu
set nu
set nowrap
set colorcolumn=100
set autochdir

" Added additionally "
set undofile
set undodir=~/.vim/undodir
set noerrorbells
set vb t_vb=

autocmd BufWritePre * %s/\s\+$//e
" End of additional mappings "

" --- Remap config ---

inoremap jj <Esc>
inoremap <Esc> <Nop>

" Remove arrow keys from all modes
" --- Normal mode ---
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" --- Insert mode ---

inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>

" --- Visual mode ---

vnoremap <Up> <Nop>
vnoremap <Down> <Nop>
vnoremap <Left> <Nop>
vnoremap <Right> <Nop>

" --- End of Remap config ---

"" Searching
set hlsearch				" highlight matches
set incsearch				" incremental searching
set ignorecase				" searches are case insensitive...
set smartcase				" ... unless they contain at least one capital letter

" fuzzy file search
set path+=**

" Starts NertTree everytime
" Should be used only for testing...
" autocmd vimenter * NERDTree



" Below configration is take from ThePrimagen "
" .vimrc can be found at:
" https://github.com/ThePrimeagen/vimrc/blob/master/.vimrc "

" nerdtree
let NERDTreeMinimalUI = 1

" You Complete Me
let g:ycm_key_list_select_completion=[]
let g:ycm_key_list_previous_completion=[]
let g:ycm_max_diagnostics_to_display=0
" DEBUG STUFFS
let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level = 'debug'
let g:ycm_warning_symbol = '.'
let g:ycm_error_symbol = '..'
let g:ycm_server_use_vim_stdout = 1
" DEBUG STUFFS

" Maybe I do not need this functionality... "
" AG items.  I need the silent ag.
if executable('ag')
  " Use ag over grep "
  set grepprg=ag\ --nogroup\ --nocolor\ --column

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore "
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache "
  let g:ctrlp_use_caching = 0
endif

" Let definitions
let mapleader= " "
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:ag_working_path_mode="r"

" For simple sizing of splits.
map - <C-W>-
map + <C-W>+

" Remaps.  This is where the magic of vim happens
nmap <leader>h :wincmd h<CR>
nmap <leader>j :wincmd j<CR>
nmap <leader>k :wincmd k<CR>
nmap <leader>l :wincmd l<CR>
nmap <leader>u :UndotreeShow<CR>
nmap <silent>; :
nmap <leader>pf :CtrlP<CR>
nnoremap <Leader>gd :GoDef<Enter>
nnoremap <Leader>pt :NERDTreeToggle<Enter>
nnoremap <silent> <Leader>pv :NERDTreeFind<CR>
nnoremap <silent> <Leader>vr :vertical resize 30<CR>
nnoremap <silent> <Leader>r+ :vertical resize +5<CR>
nnoremap <silent> <Leader>r- :vertical resize -5<CR>
nnoremap <silent> <Leader>r- :vertical resize -5<CR>
nnoremap <silent> <Leader>;; iif err != nil { <esc>o} <esc>:w<CR>
nmap <leader><leader> V
vmap <Leader>y "+y
vmap <Leader>= <C-W><C-=>

" YCM
" The best part.
nnoremap <silent> <Leader>gd :YcmCompleter GoTo<CR>
nnoremap <silent> <Leader>gf :YcmCompleter FixIt<CR>

" RG
" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap \ :Ag<SPACE>
nnoremap <Leader>ps :Ag<SPACE>

" Autocompletion
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
au FileType rust nmap gd <Plug>(rust-def)
au FileType rust nmap gs <Plug>(rust-def-split)
au FileType rust nmap gx <Plug>(rust-def-vertical)
au FileType rust nmap <leader>gd <Plug>(rust-doc)
autocmd BufEnter *.tsx set filetype=typescript
