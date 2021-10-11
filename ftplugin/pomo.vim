" Options {{{1
setl et
setl conceallevel=1
setl concealcursor=n
setl nu norelativenumber

" Pomo filetype icon {{{1
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['pomo'] = '🍅'

" Mappings {{{1
nnoremap <silent><buffer> x :<C-U>PomoCheck <bar> w<CR>
nnoremap <silent><buffer><expr> a (v:count == 0 ? 'a': ':<C-U>call pomo#AddFromDailyList()<CR>')

" Auto insert ' - [ ] '
for key in [ 'o', 'O' ]
  exe 'nnoremap <silent><buffer> '.key.' :call pomo#autoStartItem("'.key.'", "n")<CR>'
endfor
inoremap <silent><buffer> <CR> <C-O>:call pomo#autoStartItem("\n", "a")<CR>
