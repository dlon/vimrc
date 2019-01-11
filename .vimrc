set enc=utf-8

" auto-reload vimrc
autocmd! bufwritepost .vimrc :so %

" tabs
nnoremap <Tab> :tabnext<CR>
nnoremap <S-Tab> :tabprev<CR>
nnoremap <C-N> :tabnew<CR>

syntax enable
set hls

" to unset: :set noic
set ignorecase
set smartcase

" o $MYVIMRC doesn't work for some reason
command! RC exec ":o " . $MYVIMRC

" standard copy and paste
set clipboard=unnamed

" indent while maintaining selection
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" folding
set foldmethod=indent
set foldlevel=99
nnoremap + zO
nnoremap - zC

" indentation
set tabstop=4       " spaces for tab
set softtabstop=4   " tab while editing
set shiftwidth=4    " spaces for indentation
set shiftround
set expandtab
set backspace=indent,eol,start
set autoindent
set smartindent

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

" fuzzy buffer finder
nnoremap <C-B> :CtrlPBuffer<CR>

" buffers
nnoremap ;n :bn<CR>
nnoremap ;p :bp<CR>

" snippets
nnoremap <Space> /!![a-z.]*!!<CR>v/!!<CR>lc
nnoremap <S-Space> ?!![a-z.]*!!<CR>v/!!<CR>lc
imap <C-Space> <Esc><Space>
imap <C-S-Space> <Esc><S-Space>
imap <C-;> <Esc>;

filetype on
filetype plugin on
filetype indent on

function! AppendIfEmpty()
    let str = getline(".")
    if matchstr(str, '[^\s]\+') != ""
        "call feedkeys("o!!line!!")
        normal o!!line!!
    else
        "call feedkeys("A!!line!!")
        normal A!!line!!
    endif
endfunction

" python
function! PyAddImport()
    normal gg
    let word = expand("<cword>")
    while word == "import"
        normal j
        let word = expand("<cword>")
    endwhile
    normal Oimport !!module!!
endfunction

au! FileType python nmap ;f :call AppendIfEmpty()<CR><S-Space>def !!name!!(!!params!!):<CR>!!pass!!<Esc>?!![a-z]*!!<CR>3Nv/!!<CR>lc
au! FileType python nnoremap ;c :call AppendIfEmpty()<CR><S-Space>class !!name!!(!!params!!):<CR>!!pass!!<Esc>?!![a-z]*!!<CR>3Nv/!!<CR>lc
au! FileType python nmap ;i :call PyAddImport()<CR><Space>

" c
function! CAddImport()
    normal G
    let match = search("#include", "b")
    if match == 0
        normal gg
    endif
    normal o#include <!!header.h!!>
endfunction

au! FileType c nmap ;f :call AppendIfEmpty()<CR><S-Space>!!rettype!! !!name!!(!!params!!) {<CR>!!body!!<CR>}<Esc>?!![a-z.]*!!<CR>4Nv/!!<CR>lc
au! FileType c nmap ;i :call CAddImport()<CR><S-Space>

" html
function! HtmlAddTag()
    normal a<tag>!!content!!</tag>
    normal 2F<l
    redraw
    let name=input("Tag: ")
    exec "normal ce" . name
endfunction

au! FileType html nmap ;t :call HtmlAddTag()<CR>

" java
function! NewJavaFile()
    let javaTemplate = expand("$HOME/vimfiles/templates/file.java")
    exec ":0r " . javaTemplate
    exec ":%s/!!classname!!/" . expand("%:r:t") . "/g"
    redraw
    normal gg
    call feedkeys("\<Space>")
endfunction
autocmd! BufNewFile *.java call NewJavaFile()
autocmd! FileType java nmap ;f :call AppendIfEmpty()<CR><S-Space>!!rettype!! !!name!!(!!params!!) {<CR>!!body!!<CR>}<Esc>?!![a-z.]*!!<CR>4Nv/!!<CR>lc

" surround
vnoremap " "sc"<C-r>s"<Esc>
vnoremap ' "sc'<C-r>s'<Esc>
vnoremap ( "sc(<C-r>s)<Esc>
vnoremap [ "sc[<C-r>s]<Esc>
vnoremap { "sc{<C-r>s}<Esc>
nnoremap "" viwo<Esc>"sce"<C-r>s"<Esc>
nnoremap '' viwo<Esc>"sce'<C-r>s'<Esc>
