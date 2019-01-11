set enc=utf-8

" auto-reload vimrc
"autocmd! bufwritepost .vimrc :so %

" tabs
nnoremap <Tab> :tabnext<CR>
nnoremap <S-Tab> :tabprev<CR>
nnoremap <C-N> :tabnew<CR>

syntax enable
set hls

" standard copy and paste
set clipboard=unnamed

" indent while maintaining selection
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" allow folding based on indent
set foldmethod=indent
set foldlevel=99
nnoremap f za

" indentation
set tabstop=4       " spaces for tab
set softtabstop=4   " tab while editing
set shiftwidth=4    " spaces for indentation
set shiftround
set expandtab
set backspace=indent,eol,start

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

" Line numbers, nowrap
set number
set tw=80
set nowrap
set fo-=t " nowrap while typing
"set colorcolumn=80
"highlight ColorColumn ctermbg=7
highlight LineNr ctermfg=DarkGrey

" vimplug plugin manager
call plug#begin('$HOME\vimfiles\plugged')
Plug 'scrooloose/nerdtree'
call plug#end()

"autocmd vimenter * NERDTree

" fuzzy buffer finder
nnoremap <C-L> :CtrlPBuffer<CR>

" snippets
nnoremap <Space> /!![a-z.]*!!<CR>v/!!<CR>lc
nnoremap <S-Space> ?!![a-z.]*!!<CR>v/!!<CR>lc
imap <C-Space> <Esc><Space>
imap <C-S-Space> <Esc><S-Space>

filetype on

" python
function PyAddImport()
    normal gg
    let word = expand("<cword>")
    while word == "import"
        normal j
        let word = expand("<cword>")
    endwhile
    normal Oimport !!module!!
endfunction

augroup python
    au FileType python nnoremap ;f idef !!name!!(!!params!!):<CR>!!pass!!<Esc>?!![a-z]*!!<CR>3Nv/!!<CR>lc
    au FileType python nnoremap ;c iclass !!name!!(!!params!!):<CR>!!pass!!<Esc>?!![a-z]*!!<CR>3Nv/!!<CR>lc
    au FileType python nmap ;i :call PyAddImport()<CR><Space>
augroup END

" c
function CAddImport()
    normal gg
    let word = expand("<cword>")
    while word == "include"
        normal j
        let word = expand("<cword>")
    endwhile
    normal O#include <!!header.h!!>
endfunction

augroup c
    au FileType c nnoremap ;f i!!rettype!! !!name!!(!!params!!) {<CR>!!body!!<CR>}<Esc>?!![a-z.]*!!<CR>4Nv/!!<CR>lc
    au FileType c nmap ;i :call CAddImport()<CR><Space>
augroup END

" surround
vnoremap " "sc"<C-r>s"<Esc>
vnoremap ' "sc'<C-r>s'<Esc>
vnoremap ( "sc(<C-r>s)<Esc>
vnoremap [ "sc[<C-r>s]<Esc>
vnoremap { "sc{<C-r>s}<Esc>
nnoremap "" viwo<Esc>"sce"<C-r>s"<Esc>
nnoremap '' viwo<Esc>"sce'<C-r>s'<Esc>
