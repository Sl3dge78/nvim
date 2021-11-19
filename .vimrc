call plug#begin()
Plug 'puremourning/vimspector'
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-dispatch'
Plug 'rhysd/vim-clang-format'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jackguo380/vim-lsp-cxx-highlight'
call plug#end()

let $MYVIMRC="W:/.vim/.vimrc"

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
set guifont=Liberation\ Mono:h12

" Save files on build
set autowrite

" Make backspace behave normally
set backspace=indent,eol,start

" Auto Indentation for langs
set cindent

" Jump build errors
noremap é :cprev<CR>
noremap è :cnext<CR>

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
" let g:clang_jumpto_declaration_key="²"
" let g:clang_jumpto_declaration_in_preview_key="<C-W>²"
" let g:clang_format#auto_format=1
" let g:clang_format#code_style="llvm"

let c_no_curly_error = 1

let g:coc_config_home= 'W:/.vim/'
cd W:/
