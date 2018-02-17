execute pathogen#infect()

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

" NERDTree Customisations"
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '~'
