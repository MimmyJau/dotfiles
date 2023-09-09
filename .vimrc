" Makes vim behave as though .vimrc was never created
" unlet! skip_defaults_vim
" source $VIMRUNTIME/defaults.vim

set balloonevalterm     " So that ALE can use popup balloons 
set mouse=a             " So that mouse hover opens balloons in ALE
set ttymouse=xterm2     " Not really sure, but needed for above to work

syntax on               " Turns on syntax highlighting
set re=0                " Fixes bug for TypeScript files Source: https://github.com/prabirshrestha/vim-lsp/issues/786#issuecomment-1333947331
set background=dark     " So vim in tmux looks the same as vim w/o tmux

set tabstop=4           " Changes size of tab to X spaces
set shiftwidth=4        " For setting size using autoindenting or << >>
set expandtab           " So tabs become spaces
set autoindent          " Sets indent of next line equal to indent of prev line

set incsearch           " Shows incremental matches
set hlsearch            " Highlights search

set number              " Shows line numbers
set ruler               " Show line and column number
set relativenumber      " Shows line numbers as relative to current line

set clipboard=unnamed   " Copies yy yank to OSX clipboard
set foldmethod=indent
set foldlevel=99
set foldnestmax=1       " Max fold is one level
nnoremap <space> za

" Taken from https://github.com/ap/vim-buftabline
set hidden                  
nnoremap <C-N> :bnext<CR>   " For jumping to next buffer
nnoremap <C-P> :bprev<CR>   " For jumping to prev buffer
nnoremap <C-X> :bd<CR>      " For closing buffer

" Taken from :help buftabline
let g:buftabline_numbers = 2    " Show number next to buffer tab
" Type '\ [number]' to jump to buffer
nmap <leader>1 <Plug>BufTabLine.Go(1)
nmap <leader>2 <Plug>BufTabLine.Go(2)
nmap <leader>3 <Plug>BufTabLine.Go(3)
nmap <leader>4 <Plug>BufTabLine.Go(4)
nmap <leader>5 <Plug>BufTabLine.Go(5)
nmap <leader>6 <Plug>BufTabLine.Go(6)
nmap <leader>7 <Plug>BufTabLine.Go(7)
nmap <leader>8 <Plug>BufTabLine.Go(8)
nmap <leader>9 <Plug>BufTabLine.Go(9)
nmap <leader>0 <Plug>BufTabLine.Go(10)

" Filetype specific changes
filetype plugin indent on

autocmd FileType javascript setlocal tabstop=2
autocmd FileType javascript setlocal shiftwidth=2

autocmd FileType typescript setlocal tabstop=2
autocmd FileType typescript setlocal shiftwidth=2

autocmd FileType css setlocal tabstop=2
autocmd FileType css setlocal shiftwidth=2

autocmd FileType html setlocal tabstop=2
autocmd FileType html setlocal shiftwidth=2

autocmd FileType json setlocal tabstop=2
autocmd FileType json setlocal shiftwidth=2

let g:vimspector_enable_mappings = 'HUMAN'

" Plugins will be downloaded under the specified directory.
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

" Declare the list of plugins.
Plug 'jalvesaq/Nvim-R'
Plug 'whonore/Coqtail'
Plug 'lervag/vimtex'
Plug 'puremourning/vimspector'
Plug 'dense-analysis/ale'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'ap/vim-buftabline'
Plug 'morhetz/gruvbox'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-fugitive'
Plug 'RRethy/vim-illuminate'
Plug 'alvan/vim-closetag'
Plug 'ervandew/supertab'
Plug 'github/copilot.vim'

" List ends here. Plugins become visible to Vim after this call
call plug#end()

let g:ale_linters = { 'python': ['pylint', 'pyright'], 'javascript': ['eslint', 'tsserver'] }
let g:ale_python_pylint_options = '--load-plugins pylint_django'
let g:ale_fixers = { 'python': ['black'], 'javascript': ['prettier'] } 
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1

" 1) This is for showing errors on mouse hover
let g:ale_set_balloons = 1          " Shoe ALE erros in balloons on mouse hover
" 2) The next two are for using popupwin when cursor is on line
" let g:ale_cursor_detail = 1         " Enable showing errors based on cursor position
" let g:ale_floating_preview = 1      " Show ALE errors in popupwin instead of a new buffer


" To remap <C-]> to find definition and <C-^> to find references using Ale 
" Source: https://github.com/dense-analysis/ale/issues/1645#issuecomment-396414319
function ALELSPMappings()
	let l:lsp_found=0
	for l:linter in ale#linter#Get(&filetype) | if !empty(l:linter.lsp) | let l:lsp_found=1 | endif | endfor
	if (l:lsp_found)
		nnoremap <buffer> <C-]> :ALEGoToDefinition<CR>
		nnoremap <buffer> <C-^> :ALEFindReferences<CR>
	else
		silent! unmap <buffer> <C-]>
		silent! unmap <buffer> <C-^>
	endif
endfunction
autocmd BufRead,FileType * call ALELSPMappings()

" For gruvbox
autocmd vimenter * ++nested colorscheme gruvbox

" For vim-closetag
" filenames like *.xml, *.html, *.xhtml, ...
" These are the file extensions where this plugin is enabled.
"
let g:closetag_filenames = '*.html,*.xhtml,*.phtml, *.js'
 

" filenames like *.xml, *.xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
"
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'

" filetypes like xml, html, xhtml, ...
" These are the file types where this plugin is enabled.
"
let g:closetag_filetypes = 'html,xhtml,phtml,js'

" filetypes like xml, xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
"
let g:closetag_xhtml_filetypes = 'xhtml,jsx,js'

" integer value [0|1]
" This will make the list of non-closing tags case-sensitive (e.g. `<Link>` will be closed while `<link>` won't.)
"
let g:closetag_emptyTags_caseSensitive = 1

" dict
" Disables auto-close if not in a "valid" region (based on filetype)
"
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ 'typescriptreact': 'jsxRegion,tsxRegion',
    \ 'javascriptreact': 'jsxRegion',
    \ }

" Shortcut for closing tags, default is '>'
"
let g:closetag_shortcut = '>'

" Add > at current position without closing the current tag, default is ''
"
let g:closetag_close_shortcut = '<leader>>'
