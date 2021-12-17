call plug#begin()
" Themes
Plug 'morhetz/gruvbox'         
Plug 'vim-airline/vim-airline' 
" Git
Plug 'tpope/vim-fugitive'
"Async make/commands
Plug 'tpope/vim-dispatch'
Plug 'preservim/nerdtree'
call plug#end()

" Start in my work folder
cd W:/

" Add subfolders to search in find
set path+=**

"remove gui menus & stuff 
set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=L

" UTF-8

set encoding=utf-8
set fileencoding=utf-8

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
set guifont=Liberation\ Mono:h10
let g:gruvbox_bold = 0
let g:gruvbox_italicize_comments = 1

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

noremap <F3> :NERDTreeToggle<CR>
let NERDTreeChDirMode = 3
let NERDTreeMinimalUI = 1

"=== C Stuff ===
autocmd FileType c set makeprg=build.bat
autocmd FileType cpp set makeprg=build.bat
autocmd FileType c set efm=%f:%l:%c:%m
autocmd FileType cpp set efm=%f:%l:%c:%m
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
let g:dispatch_no_terminal_start = 1

"=== Odin stuff ===
autocmd FileType odin set makeprg=build.bat
autocmd FileType odin set efm=%f(%l:%c)%m
let $ODIN="W:/_tools/odin"
:command! OdinDoc call s:OpenOdinDoc(<f-args>)

function! s:OpenOdinDoc()
    let word_under_cursor = expand("<cword>")
    silent! exe "noautocmd pedit odin_doc"
    noautocmd wincmd P
    set buftype=nofile
    set filetype=odin
    exe "noautocmd r! odin doc " . $ODIN . "/core/" . word_under_cursor . " -short"
    noautocmd wincmd p
endfunction
noremap <F1> :OdinDoc<CR>
