set enc=utf-8

" tabs
nnoremap <Tab> :tabnext<CR>
nnoremap <S-Tab> :tabprev<CR>

syntax enable
set hls

" allow folding based on indent
set foldmethod=indent
set foldlevel=99
nnoremap <Space> za

" always show this statusline
set statusline=
set statusline+=%n\ 
set statusline+=%{&ff}
set statusline+=%y
set statusline+=\ %<%F
set statusline+=%m
set statusline+=%=%5l/%L
set statusline+=%4v\ 
set statusline+=0x%04B\ 
set laststatus=2

" vimplug plugin manager
call plug#begin('$HOME\vimfiles\plugged')
Plug 'scrooloose/nerdtree'
call plug#end()

"autocmd vimenter * NERDTree
