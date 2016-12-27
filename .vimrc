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

" vimplug plugin manager
call plug#begin('$HOME\vimfiles\plugged')
Plug 'scrooloose/nerdtree'
call plug#end()

"autocmd vimenter * NERDTree
