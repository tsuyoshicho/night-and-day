""" SET UP VARIABLES

" initialize variables for current theme and background state
let s:current_theme = ''
let s:current_back = ''

" get lists from vimrc
let g:nd_themelist = get(g:, 'nd_themelist')   " theme names
let g:nd_themetime = get(g:, 'nd_themetime')   " theme start times
let g:nd_themeback = get(g:, 'nd_themeback')   " theme background states

" convert 24-hour time format to minutes-after-midnight
let s:themetime = []
for i in range(0,len(g:nd_themetime)-1)
  let s:minutes = split (g:nd_themetime[i], ':')[0] * 60 +
        \ split (g:nd_themetime[i], ':')[1]
  call add(s:themetime, s:minutes)
endfor

" append 'end-of-day time' (helps simplify the check function)
call add(s:themetime, 1440)


""" DEFINE SWITCH FUNCTIONS (for switching theme/background if necessary)

" switch to scheduled theme if not already active
function! ThemeSwitch(proposed_theme)
  if a:proposed_theme != s:current_theme
    call xolox#colorscheme_switcher#switch_to(a:proposed_theme)
    let s:current_theme = a:proposed_theme
  endif
endfunction

" switch to scheduled background state if not already active
function! BackgroundSwitch(proposed_back)
  if a:proposed_back != s:current_back
    if a:proposed_back == 'dark'
      exec 'set background=dark'
      let s:current_back = 'dark'
    else
      exec 'set background=light'
      let s:current_back = 'light'
    endif
  endif
endfunction


""" DEFINE CHECK FUNCTION (for detecting which theme/bg state should be active)

function! ThemeCheck(timer)

  " get current time (in minutes-after-midnight)
  let s:time = strftime ("%H") * 60 + strftime ("%M")

  " if start-time of first theme is later than current time, select last theme
  if s:time < s:themetime[0]
    call ThemeSwitch(g:nd_themelist[-1])
    call BackgroundSwitch(g:nd_themeback[-1])

  else
    " otherwise, select theme with latest start-time before current time
    for i in range(0,len(g:nd_themelist)-1)
      if s:time + 1 > s:themetime[i] && s:time < s:themetime[i+1]
        call ThemeSwitch(g:nd_themelist[i])
        call BackgroundSwitch(g:nd_themeback[i])
      endif
    endfor
  endif

endfunction


""" RUN PLUGIN

" run immediately
call ThemeCheck('')

" run continuously
if has ('atimers')
  call timer_start(1000, 'ThemeCheck', {'repeat': -1})
else
  autocmd CursorHold * call ThemeCheck('')
endif
