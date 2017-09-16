""" SET UP VARIABLES

" initialize variables for current theme and background state
let s:current_theme = ''
let s:current_back = ''

" initialize sun data if needed
if exists('g:nd_latitude')
  call sun#NdSundata()
endif


""" PREPARE THEME TIMING

" convert start-times to minutes-after-midnight
let s:themetime = []
for i in range(0,len(g:nd_themes)-1)

  if g:nd_themes[i][0] =~ 'sun'

    if g:nd_themes[i][0] =~ '+'
      let s:minutes = split (split (g:nd_themes[i][0], ':')[0], '+')[1] * 60 +
            \ split (g:nd_themes[i][0], ':')[1]
      if split (split (g:nd_themes[i][0], ':')[0], '+')[0] == 'sunrise'
        let s:minutes = g:nd_sunrise_minutes + s:minutes
      elseif split (split (g:nd_themes[i][0], ':')[0], '+')[0] == 'sunset'
        let s:minutes = g:nd_sunset_minutes + s:minutes
      endif

    elseif g:nd_themes[i][0] =~ '-'
      let s:minutes = split (split (g:nd_themes[i][0], ':')[0], '-')[1] * 60 +
            \ split (g:nd_themes[i][0], ':')[1]
      if split (split (g:nd_themes[i][0], ':')[0], '-')[0] == 'sunrise'
        let s:minutes = g:nd_sunrise_minutes - s:minutes
      elseif split (split (g:nd_themes[i][0], ':')[0], '-')[0] == 'sunset'
        let s:minutes = g:nd_sunset_minutes - s:minutes
      endif
    endif

  else
    let s:minutes = split (g:nd_themes[i][0], ':')[0] * 60 +
          \ split (g:nd_themes[i][0], ':')[1]
  endif

  call add(s:themetime, s:minutes)
endfor

" append 'end-of-day time'
call add(s:themetime, 1440)

" define 'view theme schedule' function
function! NdSchedule()
  new | setlocal buftype=nofile
  call setline (1,'THEME SCHEDULE') | put = '==============' | put = ''
  put = 'start time     theme name' | put = '----------     ----------'
  for i in range(0,len(g:nd_themes)-1)
    let s:hshow = s:themetime[i] / 60
    let s:mshow = s:themetime[i] - s:hshow * 60
    if len(s:hshow) == 1
      let s:hshow = ' ' . s:hshow
    endif
    if len(s:mshow) == 1
      let s:mshow = '0' . s:mshow
    endif
    put = s:hshow . ':' . s:mshow . '          ' . g:nd_themes[i][1]
  endfor
  1
endfunction

" check if themes are in consecutive order
for i in range(0,len(g:nd_themes)-1)
  if s:themetime[i] >= s:themetime[i+1]
    echomsg "warning: night-and-day themes not scheduled in consecutive order"
    echomsg "(your current theme schedule will now be displayed)"
    call NdSchedule()
  endif
endfor


""" DEFINE SWITCH FUNCTIONS (for switching theme/background if necessary)

" switch to scheduled theme if not already active
function! NdThemeSwitch(proposed_theme)
  if a:proposed_theme != s:current_theme
    call xolox#colorscheme_switcher#switch_to(a:proposed_theme)
    let s:current_theme = a:proposed_theme
  endif
endfunction

" switch to scheduled background state if not already active
function! NdBackgroundSwitch(proposed_back)
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

function! NdThemeCheck(timer)

  " get current time (in minutes-after-midnight)
  let s:timenow = strftime ("%H") * 60 + strftime ("%M")

  " if start-time of first theme is later than current time, select last theme
  if s:timenow < s:themetime[0]
    call NdThemeSwitch(g:nd_themes[-1][1])
    call NdBackgroundSwitch(g:nd_themes[-1][2])

  else
    " otherwise, select theme with latest start-time before current time
    for i in range(0,len(g:nd_themes)-1)
      if s:timenow + 1 > s:themetime[i] && s:timenow < s:themetime[i+1]
        call NdThemeSwitch(g:nd_themes[i][1])
        call NdBackgroundSwitch(g:nd_themes[i][2])
      endif
    endfor
  endif

endfunction


""" RUN PLUGIN

" run immediately
call NdThemeCheck('')

" run continuously
if has ('timers')
  call timer_start(1000, 'NdThemeCheck', {'repeat': -1})
else
  autocmd CursorHold * call NdThemeCheck('')
endif
