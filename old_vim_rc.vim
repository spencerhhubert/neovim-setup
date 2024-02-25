syntax on

:set number
:set relativenumber
:set linebreak
:set cursorline

let g:loaded_matchparen=1

filetype indent on

set hlsearch
set incsearch
set showmatch

set expandtab
set ts=2
set shiftwidth=2

autocmd FileType javascript,html,typescript,haskell,svelte setlocal shiftwidth=2
autocmd FileType javascript,html,typescript,haskell,svelte setlocal ts=2
autocmd BufNewFile,BufRead *.js,*.html,*ts,*svelte,*hs setlocal shiftwidth=2
autocmd BufNewFile,BufRead *.js,*.html,*ts,*svelte,*hs setlocal ts=2
