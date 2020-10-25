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
Plug 'haya14busa/is.vim'
Plug 'inkarkat/vim-ingo-library'
Plug 'inkarkat/vim-LineJuggler'
Plug 'inkarkat/vim-ReplaceWithRegister'
Plug 'inkarkat/vim-ReplaceWithSameIndentRegister'
Plug 'majutsushi/tagbar'
Plug 'romainl/vim-qf'
Plug 'jlanzarotta/bufexplorer'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'mileszs/ack.vim'
Plug 'mbbill/undotree'
Plug 'terryma/vim-smooth-scroll'
Plug 'ngemily/vim-vp4'
Plug 'will133/vim-dirdiff'
Plug 'tpope/vim-surround'
Plug 'easymotion/vim-easymotion'
Plug 'wellle/targets.vim'
Plug 'cocopon/iceberg.vim'
Plug 'tomasiser/vim-code-dark'
Plug 'vifm/vifm.vim'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'justinmk/vim-dirvish'
Plug 'mg979/vim-visual-multi'
Plug 'dyng/ctrlsf.vim'
Plug 'mhinz/vim-startify'
Plug 'skywind3000/vim-terminal-help'

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

set incsearch
set hlsearch

" Match angle brackets...
set matchpairs+=<:>,«:»,｢:｣

"Scroll when 3 lines from top/bottom
set scrolloff=2

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

" Escape short cuts
inoremap <C-C> <ESC>
inoremap <C-\> <ESC>
vnoremap <C-C> <ESC>
vnoremap <C-\> <ESC>

" terminal-help customizations
let g:terminal_edit='drop'
let g:terminal_kill='term'

" Quick window resizing
nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>

" Move to end of line with +
nnoremap + $
vnoremap + $

" Shortcuts to move lines
nnoremap <C-J> :m .+1<CR>==
nnoremap <C-K> :m .-2<CR>==
inoremap <C-J> <Esc>:m .+1<CR>==gi
inoremap <C-K> <Esc>:m .-2<CR>==gi
vnoremap <C-J> :m '>+1<CR>gv=gv
vnoremap <C-K> :m '<-2<CR>gv=gv

" Setup relative numbering
set number relativenumber

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" vim-preview customizations
autocmd FileType qf nnoremap <silent><buffer> <M-Left> :PreviewClose<CR><C-W>=
autocmd FileType qf nnoremap <silent><buffer> <M-Right> :PreviewQuickfix<CR>
autocmd FileType qf nnoremap <silent><buffer> <C-Right> :PreviewClose<CR><CR><C-W>=
autocmd FileType qf nnoremap <silent><buffer> <Up> k:PreviewQuickfix<CR>
autocmd FileType qf nnoremap <silent><buffer> <Down> j:PreviewQuickfix<CR>

noremap <M-Up>   :PreviewScroll -1<CR>
noremap <M-Down> :PreviewScroll +1<CR>
noremap <M-Left> :PreviewClose<CR>
noremap <M-Right> :PreviewTag<CR>
noremap <C-Right> :PreviewGoto edit<CR>:PreviewClose<CR>
inoremap <M-Up>   <C-\><C-o>:PreviewScroll -1<CR>
inoremap <M-Down> <C-\><C-o>:PreviewScroll +1<CR>
inoremap <M-Left> <C-\><C-o>:PreviewClose<CR>
inoremap <M-Right> <C-\><C-o>:PreviewTag<CR>
inoremap <C-Right> <ESC>:PreviewGoto edit<CR>:PreviewClose<CR>

nnoremap <C-P> :FZF<CR>
nnoremap <C-Q> :Buffers<CR>
nnoremap <Leader>bl :BLines<CR>

function! RipgrepFzf(fuzzy, fullscreen, ...)
  let l:query = ''
  let l:path = ''
  let l:rg_args = ''

  " Parsing the variadic parameters as [query] [path...] [--] [args to rg...]
  " Corresponding states               0 ->    1 ->      2 -> 3
  let l:state = 0

  for s in a:000
      if l:state == 0
          if isdirectory(expand(s)) || filereadable(expand(s))
              let l:state = 1
          endif
      elseif l:state == 1
          if !isdirectory(expand(s)) && !filereadable(expand(s))
              let l:state = 3
          endif
      endif

      if s == '--'
          let l:state = 2
      endif

      if l:state == 0
          let l:query = s
      elseif l:state == 1
          let l:path =  l:path . ' ' . s
      elseif l:state == 3
          let l:rg_args =  l:rg_args . ' ' . s
      endif

      if l:state == 0
          let l:state = 1
      elseif l:state == 2
          let l:state = 3
      endif
  endfor

  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s -- %s %s || true'
  let initial_command = printf(command_fmt, l:rg_args, shellescape(l:query), l:path)

  if a:fuzzy
      let spec = {'options': ['--preview', '~/.vim/plugged/fzf.vim/bin/preview.sh {}']}
      call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
  else
      let reload_command = printf(command_fmt, l:rg_args, '{q}', l:path)
      let spec = {'options': ['--phony', '--query', l:query, '--bind', 'change:reload:'.reload_command, '--preview', '~/.vim/plugged/fzf.vim/bin/preview.sh {}']}
      call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
  endif
endfunction

command! -nargs=* -bang -complete=file RG call RipgrepFzf(0, <bang>0, <f-args>)
command! -nargs=* -bang -complete=file RGF call RipgrepFzf(1, <bang>0, <f-args>)

" Use ripgrep with Ack
if executable('rg')
    let g:ackprg = 'rg --vimgrep --no-heading'
else
    " Use silver searcher with Ack
    if executable('ag')
        let g:ackprg = 'ag --vimgrep'
    endif
endif

nnoremap <Leader>ss :Ack!<Space>
nnoremap <Leader>sc :Ack! -tcpp <C-R><C-W> .
nnoremap <Leader>sm :Ack! -tmeson <C-R><C-W> .
nnoremap <Leader>sp :Ack! -tpy <C-R><C-W> .

nnoremap <Leader>sr :RG!
nnoremap <Leader>sf :RGF!

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

" dirvish customizations
let g:dirvish_mode = ':sort ,^.*[\/],'

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
function! FormatRange() range
    silent exe a:firstline.",".a:lastline."py3f /usr/share/clang/clang-format-9/clang-format.py"
endfunction

command! -range Format <line1>,<line2>call FormatRange()

function! FormatMotion(type)
    silent exe line("'[").",".line("']")."Format"
endfunction

map <Leader>f :set opfunc=FormatMotion<CR>g@
vmap <Leader>f :Format<CR>
imap <Leader>f <c-o>:Format<CR>

" mucomplete
let g:mucomplete#enable_auto_at_startup = 1
let g:mucomplete#completion_delay = 200
let g:mucomplete#look_behind = 5
let g:mucomplete#chains = {}
let g:mucomplete#chains.default = ['file', 'keyn', 'dict']
let g:mucomplete#chains.cpp = ['file', 'tags']

imap <C-L> <Plug>(MUcompleteCycFwd)
imap <C-H> <Plug>(MUcompleteCycBwd)

" tagbar customizations
nnoremap <Leader>tbt :TagbarToggle<CR>
let g:tagbar_window_local = 1
let g:tagbar_autofocus = 1

" vim vmath
vmap <expr>  <Leader><Leader>+  VMATH_YankAndAnalyse()
nmap         <Leader><Leader>+  vip++

" vim-qf
let g:qf_mapping_ack_style = 1
let g:qf_max_height = 20

" DirDiff customizations
let g:DirDiffSimpleMap = 1
let g:DirDiffExcludes = "tags,*.pyc,*.swp"

" vifm customizations
if v:version >= 800
    let g:vifm_embed_term=1
    let g:vifm_embed_split=1
endif

nnoremap <Leader>= :Vifm<CR>
inoremap <Leader>= <ESC>:Vifm<CR>
if v:version >= 800
    tnoremap <Leader>= <C-W><C-C>
endif

nmap <C-S>  :setlocal spell!<CR>

noremap <silent> <C-L> :nohlsearch <bar> redraw<CR>
inoremap <silent> <C-L> <C-O>:nohlsearch <bar> redraw<CR>

let g:startify_change_to_dir = 0
