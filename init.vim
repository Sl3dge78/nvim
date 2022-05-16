call plug#begin()

" Themes
Plug 'morhetz/gruvbox'         
Plug 'vim-airline/vim-airline' 

Plug 'tpope/vim-fugitive' " Git
Plug 'tpope/vim-dispatch' "Async make/commands

" File browing/opening
Plug 'junegunn/fzf', { 'do':{ -> fzf#install() }}

Plug 'rluba/jai.vim'
Plug 'ziglang/zig.vim'
Plug 'Sl3dge78/jai.vim'

" Autocomplete
" Plug 'puremourning/vimspector'
Plug 'neoclide/coc.nvim', {'branch':'release'}

call plug#end()

"remove gui menus & stuff 
set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=L
set shortmess=at
set signcolumn=number

set shortmess=a
set cmdheight=2

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
set cinoptions=l1
syntax enable
filetype plugin indent on
set autoindent
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" File stuff
set autoread
set autowrite

" Line stuff
set number

" Theme
set background=dark
autocmd vimenter * ++nested colorscheme gruvbox
set guifont=Liberation\ Mono:h8
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

"=== C Stuff ===
autocmd FileType c set makeprg=build.bat
autocmd FileType cpp set makeprg=build.bat
autocmd FileType c set efm=%f:%l:%c:%m
autocmd FileType cpp set efm=%f:%l:%c:%m
let c_no_curly_error = 1

" Remedy setup
:command RemedyOpen :silent !start remedybg.exe .rdbg
:command RemedyStart :silent !start remedybg.exe start-debugging
:command RemedyStop :silent !start remedybg.exe stop-debugging
:command Breakpoint :exe "silent !remedybg.exe add-breakpoint-at-file %:p " line('.')
:command RemBreakpoint exe "silent !remedybg.exe remove-breakpoint-at-file %:p " line('.')

noremap <F5> :RemedyStart<CR> 
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
    
" === JAI ===
let g:jai_compiler = "jai"
autocmd FileType jai compiler jai

" === COC ===
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

nmap <silent> gd <Plug>(coc-definition)
inoremap <silent><expr> <c-space> coc#refresh()
nnoremap <silent> K :call <SID>show_documentation()<CR>
nmap <silent> gy <Plug>(coc-type-definition)

function! s:show_documentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" === VIMSPECTOR ===
let g:vimspector_enable_mappings = "HUMAN"

" == Auto complete ==
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy', 'all']
set completeopt=menuone,noinsert,noselect
let g:completion_trigger_on_delete = 1

" === JAI ===
autocmd FileType jai compiler jai


" === VIMSPECTOR ===
let g:vimspector_enable_mappings = 'HUMAN'
packadd! vimspector
