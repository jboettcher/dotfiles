set nocompatible              " be iMproved, required
filetype off                  " required

colorscheme monokai

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'lyuts/vim-rtags'
Plugin 'rdnetto/ycm-generator'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-syntastic/syntastic'
Plugin 'airblade/vim-gitgutter'
Plugin 'rhysd/vim-clang-format'
Plugin 'Valloric/YouCompleteMe'
Plugin 'derekwyatt/vim-fswitch'
Plugin 'Raimondi/delimitMate'
Plugin 'easymotion/vim-easymotion'
Plugin 'ntpeters/vim-better-whitespace'





" All of your Plugins must be added before the following line
call vundle#end()            " required
set completefunc=RtagsCompleteFunc
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

" VIM Configuration File
" Description: Optimized for C/C++ development, but useful also for other things.
"

let mapleader = ","

inoremap jk <Esc>

nnoremap <leader>gh :YcmCompleter GoToInclude<CR>
nnoremap <leader>gdec :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gdef :YcmCompleter GoToDefinition<CR>
nnoremap <leader>g :YcmCompleter GoTo<CR>
nnoremap <leader>gf :YcmCompleter GoToImprecise<CR>

let g:ycm_confirm_extra_conf=0
" map to <Leader>cf in C++ code
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>


" s{char}{char} to move to {char}{char} easymotion
nmap s <Plug>(easymotion-overwin-f2)


" delete old insert text
set backspace=2

" set UTF-8 encoding
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8
" disable vi compatibility (emulation of old bugs)
set nocompatible
" use indentation of previous line
set autoindent
" use intelligent indentation for C
set smartindent
set ignorecase
set incsearch
set smartcase
" configure tabwidth and insert spaces instead of tabs
set tabstop=2        " tab width is 2 spaces
set shiftwidth=2     " indent also with 2 spaces
set expandtab        " expand tabs to spaces

" wrap lines at 120 chars. 80 is somewaht antiquated with nowadays displays.
set textwidth=120
" turn syntax highlighting on
set t_Co=256
if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  set t_ut=
endif

syntax on
" colorscheme wombat256
" turn line numbers on
set number
" highlight matching braces
set showmatch
" intelligent comments
set comments=sl:/*,mb:\ *,elx:\ */

set cinoptions=l1
set cinoptions=L0
set cino=l1




" Enhanced keyboard mappings
nmap tc :tabnew<CR>
nmap tp :tabprev<CR>
nmap tn :tabnext<CR>

map <F9> :YcmCompleter FixIt<CR>
map <F8> :lne<CR>
map <C-F8> :lprev<CR>

"
map <C-n> :NERDTreeToggle<CR>
" switch between header/source with F3
map <F3> :FSHere<CR>
"specify where to search for include files
au! BufEnter *.hpp let b:fswitchdst = 'cpp,c' | let b:fswitchlocs = '.,../,../src,reg:/include/src/'
au! BufEnter *.cpp let b:fswitchdst = 'hpp,h' | let b:fswitchlocs = '.,include,../include,reg:/src/include/,reg:/src/include*/'
"Switch to the file and load it into a new window split on the right, and set original window active again
nmap <silent> <F4> :FSSplitRight<cr>:wincmd h<CR>

imap <F3> <C-\><C-O>:FSHere<CR>
" build using makeprg with <F7>

map <F7> :make<CR>
" in diff mode we use the spell check keys for merging
if &diff
  ” diff settings
  map <M-Down> ]c
  map <M-Up> [c
  map <M-Left> do
  map <M-Right> dp
  map <F9> :new<CR>:read !svn diff<CR>:set syntax=diff buftype=nofile<CR>gg
else
  " spell settings
  :setlocal spell spelllang=en
  " set the spellfile - folders must exist
  set spellfile=~/.vim/spellfile.add
  map <M-Down> ]s
  map <M-Up> [s
endif

" path to directory where library can be found
let g:clang_library_path='/usr/lib/llvm-4.0/lib'
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:clang_format#command='clang-format-5.0'

let g:strip_whitespace_on_save=1



set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.o,*.d,*.dwo,*.make,*.a,link.txt,depend.internal,CXX.includecache,*.cmake,CMakeCache.txt


map <F12> :! ~/Programs/rtags/bin/rdm &<CR>
