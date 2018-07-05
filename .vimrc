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


" NERDTree Customisations"
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '~'

" vim-preview customizations
autocmd FileType qf nnoremap <silent><buffer> p :PreviewQuickfix<CR>
autocmd FileType qf nnoremap <silent><buffer> P :PreviewClose<CR>

noremap <C-Up>   :PreviewScroll -1<CR>
noremap <C-Down> :PreviewScroll +1<CR>
inoremap <C-Up>   <C-\><C-o>:PreviewScroll -1<CR>
inoremap <C-Down> <C-\><C-o>:PreviewScroll +1<CR>

noremap <C-p> :PreviewTag<CR>
inoremap <C-p> <C-\><C-o>:PreviewTag<CR>
