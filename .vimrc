call plug#begin()
" Themes
Plug 'morhetz/gruvbox'         
Plug 'vim-airline/vim-airline' 
" Git
Plug 'tpope/vim-fugitive'
"Async make/commands
Plug 'tpope/vim-dispatch'
call plug#end()

" Start in my work folder
cd W:/

"remove gui menus & stuff 
set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=L

" Tab stuff
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4
set smarttab
set startofline

" Indentation stuff
set cindent
syntax enable
filetype plugin indent on
set autoindent

" File stuff
set autoread
set autowrite
set directory=W:\\_vim\\temp
set backupdir=W:\\_vim\\temp
set undodir=W:\\_vim\\temp

" Line stuff
set cursorline
set number

" Theme
set background=dark
autocmd vimenter * ++nested colorscheme gruvbox
set guifont=Liberation\ Mono:h11

" Make backspace behave normally
set backspace=indent,eol,start

" Jump build errors
noremap é :cprev<CR>
noremap è :cnext<CR>

" Move window to window with CTRL+movement
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

" Resize windows with CTRL+Arrows
noremap <C-Up>    <C-w>+
noremap <C-Down>  <C-w>-
noremap <C-Left>  <C-w><
noremap <C-Right> <C-w>>

" Coc config
let g:coc_config_home= 'W:/_vim/'

"=== C Stuff ===
autocmd FileType c set makeprg=build.bat
autocmd FileType c set efm=%f:%l:%c:%m
let c_no_curly_error = 1
" Remedy setup
:command Remedy Start remedybg.exe start-debugging
:command RemedyStop Start! remedybg.exe stop-debugging
:command Breakpoint :exe "silent !remedybg.exe add-breakpoint-at-file %:p " line('.')
:command RemBreakpoint exe "silent !remedybg.exe remove-breakpoint-at-file %:p " line('.')

noremap <F5> :Remedy<CR> 
noremap <S-F5> :RemedyStop<CR>
noremap <F9> :Breakpoint<CR>
noremap <S-F9> :RemBreakpoint<CR>

"=== Rust stuff ===
autocmd FileType rust set makeprg=cargo\ build
autocmd FileType rust set efm=%Aerror[E%n]:\ %m,%Awarning:\ %m,%C\ \-\-\>\ %f:%l:%c
autocmd FileType rust :command Run :Spawn!cargo run
let g:dispatch_no_terminal_start = 1
