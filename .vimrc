call plug#begin()
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-dispatch'
Plug 'rhysd/vim-clang-format'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jackguo380/vim-lsp-cxx-highlight'
call plug#end()

let $MYVIMRC="W:/_vim/.vimrc"

set guioptions-=m 
set guioptions-=T
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar

" Tabs as 4 spaces
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4
set smarttab
set startofline

" Highlight current line
set cursorline
set number

" Vimspector for python
" let g:vimspector_enable_mappings = 'HUMAN'
let g:python_host_prog = "C:/Python27/python.exe"
let g:python3_host_prog = "C:/Python39/python.exe"

" Theme
set background=dark
autocmd vimenter * ++nested colorscheme gruvbox
set guifont=Liberation\ Mono:h11

" Save files on build
set autowrite

" Make backspace behave normally
set backspace=indent,eol,start

" Auto Indentation for langs
set cindent
syntax enable
filetype plugin indent on

" Jump build errors
noremap é :cprev<CR>
noremap è :cnext<CR>

noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

noremap <C-Up>    <C-w>+
noremap <C-Down>  <C-w>-
noremap <C-Left>  <C-w><
noremap <C-Right> <C-w>>

" Remedy setup
:command Remedy !remedybg.exe start-debugging
:command RemedyStop :silent !remedybg.exe stop-debugging
:command Breakpoint :exe "silent !remedybg.exe add-breakpoint-at-file %:p " line('.')
:command RemBreakpoint :exe "silent !remedybg.exe remove-breakpoint-at-file %:p " line('.')

noremap <F5> :Remedy<CR> 
noremap <S-F5> :RemedyStop<CR>
noremap <F9> :Breakpoint<CR>
noremap <S-F9> :RemBreakpoint<CR>

" clang_complete config
" let g:clang_library_path='D:\Program Files\LLVM\bin'
" let g:clang_jumpto_declaration_key="Â²"
" let g:clang_jumpto_declaration_in_preview_key="<C-W>Â²"
" let g:clang_format#auto_format=1
" let g:clang_format#code_style="llvm"

let c_no_curly_error = 1

let g:coc_config_home= 'W:/_vim/'
cd W:/

" Set the compiler to cargo upon opening an .rs file
autocmd FileType rust set makeprg=cargo\ build
autocmd FileType rust set efm=%Aerror[E%n]:\ %m,%Awarning:\ %m,%C\ \-\-\>\ %f:%l:%c
:command Run :Spawn!cargo run
let g:dispatch_no_terminal_start = 1
