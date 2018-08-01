execute pathogen#infect()

" Get vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a directory for vim-plug plugins
call plug#begin('~/.vim/plugged')

Plug 'skywind3000/vim-preview'

" Initialize plugin system
call plug#end()

colorscheme molokai

syntax enable

filetype plugin indent on

" show existing tab with 4 spaces width"
set tabstop=4
" when indenting with '>', use 4 spaces width"
set shiftwidth=4
" On pressing tab, insert 4 spaces"
set expandtab
" Remove trailing white spaces upon writing
autocmd BufWritePre * %s/\s\+$//e

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

" search cutomizations

set incsearch

" Enable search highlights at every search
noremap * :set hlsearch<CR>:nohlsearch<CR>*
noremap / :set hlsearch<CR>:nohlsearch<CR>/
noremap ? :set hlsearch<CR>:nohlsearch<CR>?

" shortcut to toggle highlights
noremap <C-H> :set hlsearch!<CR>

" vim-preview customizations
autocmd FileType qf nnoremap <silent><buffer> <C-Left> :PreviewClose<CR>
autocmd FileType qf nnoremap <silent><buffer> <C-Right> :PreviewQuickfix<CR>
autocmd FileType qf nnoremap <silent><buffer> <S-Right> :PreviewClose<CR><CR>
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

" Use silver searcher with Ack
if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif

nnoremap <Leader>a :Ack!<Space>

let g:CommandTFileScanner = 'find'
let g:CommandTMaxFiles=200000
