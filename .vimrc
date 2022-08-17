" Makes vim behave as though .vimrc was never created
" unlet! skip_defaults_vim
" source $VIMRUNTIME/defaults.vim

syntax on               " Turns on syntax highlighting

set tabstop=4           " Changes size of tab to X spaces
set shiftwidth=4        " For setting size using autoindenting or << >>
set expandtab           " So tabs become spaces
set autoindent          " Sets indent of next line equal to indent of prev line
" set smartindent       " May autoindent next line based on context

" Filetype specific changes
autocmd FileType javascript setlocal tabstop=2
autocmd FileType javascript setlocal shiftwidth=2

autocmd FileType css setlocal tabstop=2
autocmd FileType css setlocal shiftwidth=2

autocmd FileType html setlocal tabstop=2
autocmd FileType html setlocal shiftwidth=2

autocmd FileType json setlocal tabstop=2
autocmd FileType json setlocal shiftwidth=2

set incsearch           " Shows incremental matches
set hlsearch            " Highlights search

set number              " Shows line numbers
set relativenumber      " Shows line numbers as relative to current line

set clipboard=unnamed   " Copies yy yank to OSX clipboard


" Plugins will be downloaded under the specified directory.
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

" Declare the list of plugins.
Plug 'jalvesaq/Nvim-R'
Plug 'whonore/Coqtail'
Plug 'lervag/vimtex'

" List ends here. Plugins become visible to Vim after this call
call plug#end()
