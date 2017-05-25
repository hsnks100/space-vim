scriptencoding=utf-8

nnoremap <leader>fed :e ~/.space-vim/private/config.vim<CR>
nnoremap <leader>feR :source ~/.space-vim/private/config.vim<CR> 



set guifont=나눔고딕코딩\ 14
noremap YY :%y+<CR> 
vnoremap Y "+y
vnoremap <C-C> :"+y<CR>
inoremap <C-V> <ESC>"+p`]o

nmap <C-j> :bn<CR>
nmap <C-k> :bp<CR>
nnoremap <C-w><C-q> <C-W>q
vnoremap p "_dP=`]`]
nnoremap p p=`]`]
nnoremap x "_x
vnoremap x "_x

nnoremap S "_dp

set norelativenumber





set autochdir
"""""""""""""""""""""""""""""
" => bufExplorer plugin
""""""""""""""""""""""""""""""
let g:bufExplorerDefaultHelp=0
let g:bufExplorerSortBy='name' 
nmap <leader>o :BufExplorer<cr>





" compile setting
function! Kompile() 
    let b:buildstr = ""
    let l:ext = expand("%:e")
    echo "call kompile"
    if l:ext == "cpp" 
        let b:buildstr = "g++ -std=c++11 -O2 ".expand("%:p")." -o ".expand("%<")
    elseif  l:ext == "py"
        let b:buildstr = "python ".expand("%:p")
    elseif l:ext == "r"
        let b:buildstr = "Rscript ".expand("%:p")
    elseif l:ext == "pl"
        let b:buildstr = "perl ".expand("%:p")
    elseif l:ext == "m"
        let b:buildstr = "octave -qf ".expand("%:p")
    endif

    if filereadable("input.txt")
        let b:buildstr .= " < input.txt"
    endif

    if executable('tmux') && !has('gui')
        call VimuxRunCommand("cd ".expand("%:p:h"))
        call VimuxRunCommand(b:buildstr) 
    else
        let b:buildstr = substitute(b:buildstr, " ", "\\\\ ", "g")
        echo b:buildstr
        silent execute "setlocal makeprg=".b:buildstr
        make
        vertical botright copen
    endif
endfunction


function! Exekute()
    if executable("tmux") && !has('gui')
        call VimuxRunCommand(expand("%:p:r") . " <input.txt")
    else
        " noremap <F6> :cexpr system('./'.expand('%:r') .'< input.txt')<CR>:cope<CR><C-w>p
        execute "cexpr system(\"" . expand('%:p:r') . " <input.txt\")"
        normal <CR>
        vertical botright copen
        "execute("vertical botright cope")
        "  <CR>:cop<CR><C-w>p"
    endif
endfunction


if has("win32")
    autocmd FileType cpp setlocal makeprg=g++\ -g\ -std=gnu++11\ %:r.cpp\ -o\ %<.exe
    autocmd FileType pl,perl setlocal makeprg=perl\ %\ <input.txt
    autocmd FileType py,python setlocal makeprg=python\ %
    noremap <C-S-B> :wa<CR>:make<CR>:cope<CR><C-w>p
    "autocmd FileType cpp noremap <buffer> <C-F5> :cexpr system('./'.expand('%:r') .'.exe< input.txt')<CR>:cope<CR><C-w>p
    autocmd FileType cpp noremap <buffer> <C-F5> :cexpr system(expand('%:r') ." <input.txt")<CR>:cope<CR><C-w>p
    autocmd FileType cpp noremap <buffer> <C-F6> :cexpr system(expand('%:r'))<CR>:cope<CR><C-w>p
    autocmd FileType cpp noremap <buffer> <F5> :!gdb %<.exe input.txt<CR>:cope<CR><C-w>p
    "noremap <F5> :wa<CR>:make<CR>
    "noremap <C-F5> :! %<.exe < input.txt<CR>
    "autocmd FileType cpp set makeprg=g++\ -std=c++11\ %:r.cpp\ -o\ %<.exe
    "noremap <F9> :call Run()<CR>
    "inoremap <F9> <ESC>:call Run()<CR> 
else 
    noremap <F6> :cexpr system('./'.expand('%:r') .'< input.txt')<CR>:cope<CR><C-w>p
    noremap <C-S-B> :wa<CR>:call Kompile()<CR><c-w>p
    " autocmd FileType cpp noremap <buffer> <F5> :call Exekute()<CR><c-w>p
endif
