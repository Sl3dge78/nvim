call plug#begin()
Plug 'puremourning/vimspector'
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
call plug#end()

set number
let g:vimspector_enable_mappings = 'HUMAN'
let g:python_host_prog = "C:/Python27/python.exe"
let g:python3_host_prog = "C:/Python39/python.exe"
autocmd vimenter * ++nested colorscheme gruvbox
