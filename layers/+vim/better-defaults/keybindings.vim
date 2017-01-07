" Reload .vimrc
nnoremap <Leader>fR :source $MYVIMRC<CR>

" Use Tab to switch buffer
nnoremap <Tab> :bn<CR>

" Use Ctrl-Tab and Alt-Tab to switch tab
map    <C-Tab>  :tabnext<CR>
imap   <C-Tab>  <C-O>:tabnext<CR>
map    <M-Tab>  :tabprev<CR>
imap   <M-Tab>  <C-O>:tabprev<CR>

" <Leader>w[1-9] move to window [1-9]
for i in range(1, 9)
    execute 'nnoremap <Leader>' . i . ' :' . i . 'wincmd w<CR>'
    call SpacevimBind('nmap', 'swtich-to-window-' . i, i . 'wincmd w<CR>', 1)
endfor

" Startify
nnoremap <silent><Leader>bh :Startify<CR>

" vim-better-whitespace
nnoremap <Leader>xd :StripWhitespace<CR>
call SpacevimBind('nmap', 'xd','strip-white-space')

" nerdtree
nnoremap <F4> :NERDTreeToggle<CR>
inoremap <F4> <ESC>:NERDTreeToggle<CR>

let s:lines=&lines
let s:columns=&columns
function! s:enter_full_screen()
    set lines=999 columns=999
    set fullscreen
endfunction

function! s:leave_full_screen()
    let &lines=s:lines
    let &columns=s:columns
    set nofullscreen
endfunction

function! s:full_screen_toggle()
    if &fullscreen
        call s:leave_full_screen()
    else
        call s:enter_full_screen()
    endif
endfunction

augroup SPACEVIM_GUI
    autocmd!
    autocmd GUIEnter * nnoremap <Leader>wm :call <SID>full_screen_toggle()<CR>
augroup END
