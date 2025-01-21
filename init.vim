call plug#begin()

" Themes
Plug 'morhetz/gruvbox'         
Plug 'vim-airline/vim-airline' 

Plug 'kdheepak/lazygit.nvim'
Plug 'tpope/vim-dispatch' 

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'rluba/jai.vim'
Plug 'ziglang/zig.vim'

Plug 'puremourning/vimspector'
Plug 'rust-lang/rust.vim'

Plug 'tikhomirov/vim-glsl'

Plug 'rmagatti/auto-session'
Plug 'sheerun/vim-polyglot'

Plug 'neovim/nvim-lspconfig'
call plug#end()

"remove gui menus & stuff 
set guioptions-=m
set guioptions-=T
set guioptions-=
set guioptions-=L
set signcolumn=number

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
set breakindent
set breakindentopt=shift:2,sbr

" File stuff
set autoread
set autowrite
set nobackup
set nowritebackup

" Line stuff
set number

" Theme
set background=dark
autocmd vimenter * ++nested colorscheme gruvbox
set guifont=Source\ Code\ Pro:h10
let g:gruvbox_bold = 0
let g:gruvbox_italicize_comments = 1
let g:airline_symbols_ascii = 1

" Make backspace behave normally
set backspace=indent,eol,start

" Jump build errors
noremap <C-2> :cp<CR>
noremap <C-7> :cn<CR>

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
" autocmd FileType c set makeprg=build.bat
" autocmd FileType cpp set makeprg=build.bat
" autocmd FileType c set efm=%f:%l:%c:%m
" autocmd FileType cpp set efm=%f:%l:%c:%m
let c_no_curly_error = 1

" === Vimspector ===
let g:vimspector_enable_mappings = 'HUMAN'

" === Remedy setup ===
" :command RemedyOpen :silent !start remedybg.exe .rdbg
" :command RemedyStart :silent !start remedybg.exe start-debugging
" :command RemedyStop :silent !start remedybg.exe stop-debugging
" :command Breakpoint :exe "silent !remedybg.exe add-breakpoint-at-file %:p " line('.')
" :command RemBreakpoint exe "silent !remedybg.exe remove-breakpoint-at-file %:p " line('.')

" noremap <F5> :RemedyStart<CR> 
" noremap <S-F5> :RemedyStop<CR>
" noremap <F9> :Breakpoint<CR>
" noremap <S-F9> :RemBreakpoint<CR>

"=== Rust stuff ===
let g:cargo_makeprg_params = 'build'

" === JAI ===
let g:jai_compiler = "jai"
autocmd FileType jai compiler jai

" Search for an ident in the compiler folder (modules & how_to)
function! s:JaiSearch(myParam) 
    exe "vimgrep /". a:myParam ."/ /opt/jai/**/*.jai"
endfunction
command! -nargs=1 JaiFind call s:JaiSearch(<f-args>)

function! s:OpenJaiDoc(param)
    silent! exe "noautocmd pedit jai_doc"
    noautocmd wincmd P
    set buftype=nofile
    set filetype=jai
    exe "noautocmd r! jai -no_color /opt/jai/examples/module_info.jai - " . a:param 
    noautocmd wincmd p
endfunction
command! -nargs=1 JaiDoc call s:OpenJaiDoc(<f-args>)

" === Telescope ===
nnoremap <F1> <cmd>Telescope find_files<cr>
nnoremap <F2> <cmd>Telescope live_grep<cr>
nnoremap <F3> <cmd>Telescope grep_string<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" === LSP =====
:lua << EOF
    local lspconfig = require('lspconfig')

    local opts = { noremap=true, silent=true }
    vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

    -- Use an on_attach function to only map the following keys
    -- after the language server attaches to the current buffer
    local on_attach = function(client, bufnr)
      vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

      -- Mappings.
      -- See `:help vim.lsp.*` for documentation on any of the below functions
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    end

    -- " lspconfig['rust_analyzer'].setup {
    --     " on_attach = on_attach,
    --     " flags = lsp_flags,
    --     " -- Server-specific settings...
    --     " settings = {
    --       " ["rust-analyzer"] = {}
    --     " }
    -- " }
    
    -- run : `dotnet tool install --global csharp-ls`
    -- https://github.com/razzmatazz/csharp-language-server
    lspconfig['csharp_ls'].setup {
        cmd = {"csharp-ls"},
      -- cmd = { "C:/users/guillaumec/Downloads/omnisharp-win-x64-net6.0/OmniSharp.exe", "--language-server", "--hostPID", tostring(vim.fn.getpid()) },
      -- cmd = { 'mono', '--assembly-loader=strict', "C:/users/guillaumec/Downloads/omnisharp-win-x64/OmniSharp.exe" },
      -- root_dir = lspconfig.util.root_pattern("*.sln"),
      on_attach = on_attach,
      -- use_mono = true,
    }
EOF

" == Auto complete ==
"" let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy', 'all']
"" set completeopt=menuone,noinsert,noselect
"" let g:completion_trigger_on_delete = 1
"" 
"" " == Coc ==
"" inoremap <silent><expr> <CR>
""       \ coc#pum#visible() ? coc#pum#confirm()
""       \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
"" 
"" 
"" " Use <c-space> to trigger completion
"" if has('nvim')
""   inoremap <silent><expr> <c-space> coc#refresh()
"" else
""   inoremap <silent><expr> <c-@> coc#refresh()
"" endif
"" 
"" " Use `[g` and `]g` to navigate diagnostics
"" " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
"" nmap <silent> [g <Plug>(coc-diagnostic-prev)
"" nmap <silent> ]g <Plug>(coc-diagnostic-next)
"" 
"" " GoTo code navigation
"" nmap <silent> gd <Plug>(coc-definition)
"" nmap <silent> gy <Plug>(coc-type-definition)
"" nmap <silent> gi <Plug>(coc-implementation)
"" nmap <silent> gr <Plug>(coc-references)
"" 
"" " Use K to show documentation in preview window
"" nnoremap <silent> K :call ShowDocumentation()<CR>
"" 
"" function! ShowDocumentation()
""   if CocAction('hasProvider', 'hover')
""     call CocActionAsync('doHover')
""   else
""     call feedkeys('K', 'in')
""   endif
"" endfunction
"" 
"" " Highlight the symbol and its references when holding the cursor
"" autocmd CursorHold * silent call CocActionAsync('highlight')
"" 
"" " Symbol renaming
"" nmap <leader>rn <Plug>(coc-rename)
"" 
"" " Formatting selected code
"" xmap <leader>f  <Plug>(coc-format-selected)
"" nmap <leader>f  <Plug>(coc-format-selected)
"" 
"" augroup mygroup
""   autocmd!
""   " Setup formatexpr specified filetype(s)
""   autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
""   " Update signature help on jump placeholder
""   autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
"" augroup end
"" 
"" " Applying code actions to the selected code block
"" " Example: `<leader>aap` for current paragraph
"" xmap <leader>a  <Plug>(coc-codeaction-selected)
"" nmap <leader>a  <Plug>(coc-codeaction-selected)
"" 
"" " Remap keys for applying code actions at the cursor position
"" nmap <leader>ac  <Plug>(coc-codeaction-cursor)
"" " Remap keys for apply code actions affect whole buffer
"" nmap <leader>as  <Plug>(coc-codeaction-source)
"" " Apply the most preferred quickfix action to fix diagnostic on the current line
"" nmap <leader>qf  <Plug>(coc-fix-current)
"" 
"" " Remap keys for applying refactor code actions
"" nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
"" xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
"" nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
"" 
"" " Run the Code Lens action on the current line
"" nmap <leader>cl  <Plug>(coc-codelens-action)
"" 
"" " Map function and class text objects
"" " NOTE: Requires 'textDocument.documentSymbol' support from the language server
"" xmap if <Plug>(coc-funcobj-i)
"" omap if <Plug>(coc-funcobj-i)
"" xmap af <Plug>(coc-funcobj-a)
"" omap af <Plug>(coc-funcobj-a)
"" xmap ic <Plug>(coc-classobj-i)
"" omap ic <Plug>(coc-classobj-i)
"" xmap ac <Plug>(coc-classobj-a)
"" omap ac <Plug>(coc-classobj-a)
"" 
"" " Remap <C-f> and <C-b> to scroll float windows/popups
"" if has('nvim-0.4.0') || has('patch-8.2.0750')
""   nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
""   nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
""   inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
""   inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
""   vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
""   vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
"" endif
"" 
"" " Use CTRL-S for selections ranges
"" " Requires 'textDocument/selectionRange' support of language server
"" nmap <silent> <C-s> <Plug>(coc-range-select)
"" xmap <silent> <C-s> <Plug>(coc-range-select)
"" " Add `:Format` command to format current buffer
"" command! -nargs=0 Format :call CocActionAsync('format')
"" 
"" " Add `:Fold` command to fold current buffer
"" command! -nargs=? Fold :call     CocAction('fold', <f-args>)
"" 
"" " Add `:OR` command for organize imports of the current buffer
"" command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')
"" " Mappings for CoCList
"" " Show all diagnostics
"" nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
"" " Manage extensions
"" nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
"" " Show commands
"" nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
"" " Find symbol of current document
"" nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
"" " Search workspace symbols
"" nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
"" " Do default action for next item
"" nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
"" " Do default action for previous item
"" nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
"" " Resume latest coc list
"" nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
"" 
