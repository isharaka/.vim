execute pathogen#infect()

" Get vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a directory for vim-plug plugins
call plug#begin('~/.vim/plugged')

Plug 'skywind3000/vim-preview'
Plug 'junegunn/fzf', { 'dir': '~/tools/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
Plug 'gregsexton/gitv', {'on': ['Gitv']}
Plug 'lifepillar/vim-mucomplete'
Plug 'haya14busa/incsearch.vim'
Plug 'inkarkat/vim-ReplaceWithRegister'
Plug 'inkarkat/vim-ReplaceWithSameIndentRegister'

" Initialize plugin system
call plug#end()

colorscheme sublimemonokai

syntax enable

filetype plugin indent on

set undodir=~/.vim/undodir/
set undofile

" show existing tab with 4 spaces width"
set tabstop=4
" when indenting with '>', use 4 spaces width"
set shiftwidth=4
" On pressing tab, insert 4 spaces"
set expandtab
" Allow backspace to go over autoindent, line breaks and start of insert
set backspace=indent,eol,start
" Remove trailing white spaces upon writing
autocmd BufWritePre * %s/\s\+$//e

set completeopt+=menuone
set completeopt+=noselect

" Aliases for CTRL + Arrow Key
map <ESC>[5A <C-Up>
map <ESC>[5B <C-Down>
map <ESC>[5C <C-Right>
map <ESC>[5D <C-Left>
map! <ESC>[5A <C-Up>
map! <ESC>[5B <C-Down>
map! <ESC>[5C <C-Right>
map! <ESC>[5D <C-Left>

map <ESC>[2A <S-Up>
map <ESC>[2B <S-Down>
map <ESC>[2C <S-Right>
map <ESC>[2D <S-Left>
map! <ESC>[2A <S-Up>
map! <ESC>[2B <S-Down>
map! <ESC>[2C <S-Right>
map! <ESC>[2D <S-Left>

" Map Leader to space
let mapleader = " "
" Escape short cuts
inoremap <C-C> <ESC>
inoremap <C-\> <ESC>
vnoremap <C-C> <ESC>
vnoremap <C-\> <ESC>

" MOve to end of line with +
nnoremap + $
vnoremap + $

" Quicker window movement
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-H> <C-W>h
nnoremap <C-L> <C-W>l

" Setup relative numbering
set number relativenumber

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" incsearch cutomizations
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" :h g:incsearch#auto_nohlsearch
set hlsearch
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

" vim-preview customizations
autocmd FileType qf nnoremap <silent><buffer> <C-Left> :PreviewClose<CR><C-W>=
autocmd FileType qf nnoremap <silent><buffer> <C-Right> :PreviewQuickfix<CR>
autocmd FileType qf nnoremap <silent><buffer> <S-Right> :PreviewClose<CR><CR><C-W>=
autocmd FileType qf nnoremap <silent><buffer> <Up> k:PreviewQuickfix<CR>
autocmd FileType qf nnoremap <silent><buffer> <Down> j:PreviewQuickfix<CR>

noremap <C-Up>   :PreviewScroll -1<CR>
noremap <C-Down> :PreviewScroll +1<CR>
noremap <C-Left> :PreviewClose<CR>
noremap <C-Right> :PreviewTag<CR>
noremap <S-Right> :PreviewGoto edit<CR>:PreviewClose<CR>
inoremap <C-Up>   <C-\><C-o>:PreviewScroll -1<CR>
inoremap <C-Down> <C-\><C-o>:PreviewScroll +1<CR>
inoremap <C-Left> <C-\><C-o>:PreviewClose<CR>
inoremap <C-Right> <C-\><C-o>:PreviewTag<CR>
inoremap <S-Right> <ESC>:PreviewGoto edit<CR>:PreviewClose<CR>

nnoremap <C-P> :FZF<CR>
nnoremap <C-N> :Buffers<CR>

" Use ripgrep with Ack
if executable('rg')
    let g:ackprg = 'rg --vimgrep --no-heading'
else
    " Use silver searcher with Ack
    if executable('ag')
        let g:ackprg = 'ag --vimgrep'
    endif
endif

nnoremap <Leader>a :Ack!<Space>

" netrw customizations

" preview window uses vertical split
let g:netrw_preview   = 1
" default list style - tree
let g:netrw_liststyle = 3
" make netrw window take minimum size when previewing file
let g:netrw_winsize   = 0

augroup netrw_mapping
    autocmd!
    autocmd filetype netrw call NetrwMapping()
    autocmd filetype netrw setl bufhidden=wipe
augroup END

function! NetrwMapping()
  " open file in previous window and retain focue
  nmap <buffer><silent> <C-G> <C-W>w<C-W>pP<C-W>p
  nmap <buffer><silent> go <C-W>w<C-W>pP<C-W>p
endfunction

" detect remote ssh session
let g:remote_session = ($SSH_CLIENT != "")

" disable smooth scrolling for remote sessions
if g:remote_session
    let g:scroll_disable_mapping = 1
endif

let g:ms_per_line=1

" undotree customizations
let g:undotree_WindowLayout = 2

nnoremap <Leader>ut :UndotreeToggle<CR>
inoremap <Leader>ut <ESC>:UndotreeToggle<CR>
nnoremap <Leader>uf :UndotreeFocus<CR>

" clang-format shortcuts
map <C-A> :py3f /usr/share/clang/clang-format-6.0/clang-format.py<CR>
imap <C-A> <c-o>:py3f /usr/share/clang/clang-format-6.0/clang-format.py<CR>

" mucomplete
let g:mucomplete#enable_auto_at_startup = 1
let g:mucomplete#chains = {}
let g:mucomplete#chains.default = ['file', 'keyn', 'dict']
let g:mucomplete#chains.cpp = ['file', 'tags']
