scriptencoding utf-8

" nerdcommenter {
    let g:NERDSpaceDelims=1

    nmap _ <Plug>NERDCommenterToggle
    omap _ <Plug>NERDCommenterToggle
    vmap _ <Plug>NERDCommenterToggle
" }

" vim-multiple-cursors {
    let g:multi_cursor_next_key='<C-j>'
    let g:multi_cursor_prev_key='<C-k>'
    let g:multi_cursor_skip_key='<C-x>'
    let g:multi_cursor_quit_key='<Esc>'
" }

" vim-swoop {
    " Do not let vim-swoop create keybindings
    let g:swoopUseDefaultKeyMap = 0
    " Visual selection mode mapping: swoop current selection.
    vmap <Leader>s :call SwoopMultiSelection()<CR>
    " Normal mode mapping:
    "   <Leader>ss to start swoop buffer.
    "   <Leader>sm to swoop in multiple buffers.
    nnoremap <Leader>ss :call Swoop()<CR>
    nnoremap <Leader>sm :call SwoopMulti()<CR>
" }
