""" SET UP VARIABLES

" initialize variables for current theme and background state
let s:current_theme = ''
let s:current_back = ''

" get vimrc config
let g:nd_themes = get(g:, 'nd_themes')

" convert time to minutes-after-midnight
let s:themetime = []
for i in range(0,len(g:nd_themes)-1)
  let s:minutes = split (g:nd_themes[i][0], ':')[0] * 60 +
        \ split (g:nd_themes[i][0], ':')[1]
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
  let s:timenow = strftime ("%H") * 60 + strftime ("%M")

  " if start-time of first theme is later than current time, select last theme
  if s:timenow < s:themetime[0]
    call ThemeSwitch(g:nd_themes[-1][1])
    call BackgroundSwitch(g:nd_themes[-1][2])

  else
    " otherwise, select theme with latest start-time before current time
    for i in range(0,len(g:nd_themes)-1)
      if s:timenow + 1 > s:themetime[i] && s:timenow < s:themetime[i+1]
        call ThemeSwitch(g:nd_themes[i][1])
        call BackgroundSwitch(g:nd_themes[i][2])
      endif
    endfor
  endif

endfunction


""" RUN PLUGIN

" run immediately
call ThemeCheck('')

" run continuously
if has ('timers')
  call timer_start(1000, 'ThemeCheck', {'repeat': -1})
else
  autocmd CursorHold * call ThemeCheck('')
endif
