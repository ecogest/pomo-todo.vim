" Guard {{{1
"
if exists("g:pomo_todo_loaded")
  finish
endif
let g:pomo_todo_loaded = 1

" Goal {{{1
" Structure:
" ~/.trackdir
" |- 2020
" 	|- 02
" 		|- 10
" 			|- pomo.md # daily todo + todo / brief for each pomo


" What pomo.md could look like:
" # Todo
" - [x] Do this
" - [x] Do that
"
" # Pomo 2
" ## Todo
" - [x] Do that
"
" ## Brief
" - Viewed this
"
" # Pomo 1
"
" ## Todo
" - [x] Do this
" - [ ] Do that
"
" ## Brief
" - [x] Done these too
" - Difficulty in doing that

" Ideally the file would appear in a floating window (but pain in the a..)

" Global variables {{{1
"
if !exists("g:track_dir")
  let g:track_dir=$HOME.'/.trackdir'
endif
if !exists("g:pomo_file_name")
  let g:pomo_file_name='daily.pomo'
endif
if !exists("g:pomo_todo_file")
  let g:pomo_todo_file=g:track_dir.'/todo.pomo'
endif
if !exists("g:pomo_symbol")
  let g:pomo_symbol=''
endif
if !exists("g:pomo_todo_symbol")
  let g:pomo_todo_symbol='' "   
endif
if !exists("g:pomo_brief_symbol")
  let g:pomo_brief_symbol=''
endif
if !exists("g:pomo_done_symbol")
  let g:pomo_done_symbol=''
endif
if !exists("g:pomo_empty_symbol")
  let g:pomo_empty_symbol=''
endif

" Autocommands {{{1
" Set filetype
augroup Pomo_Todo
  au!
  au BufNewFile,BufFilePre,BufRead *.pomo setf pomo
  " Replace Done symbols and save daily todolist to file on write
  au BufWrite *.pomo PomoReplaceDone | PomoSaveTodo
augroup END

" Commands {{{1
" Main command:
command! -nargs=1 PomoTracker call pomo#PomoTracker(<f-args>)
" Other utils:
" replace all done markers '[x]' with the chosen symbol (eg:  )
command! -bar PomoReplaceDone call pomo#PomoReplaceDone()
" Save all unchecked task from daily todo section to a file in the trackdir
" folder
command! -bar PomoSaveTodo call pomo#PomoSaveTodoList()
" check a line and duplicate from DailyTodo and last pomo sections
command! -bar PomoCheck call pomo#PomoMarkLineChecked()
