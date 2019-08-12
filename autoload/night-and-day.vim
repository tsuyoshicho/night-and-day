scriptencoding utf-8

let s:save_cpo = &cpo
set cpo&vim

" define 'view theme schedule' function
function! night_and_day#schedule()
  new | setlocal buftype=nofile
  call setline (1,'THEME SCHEDULE') | put = '==============' | put = ''
  put = 'start time      theme name' | put = '----------      ----------------'
  for i in range(0,len(g:nd_themes)-1)
    let s:hshow = s:themetime[i] / 60
    let s:mshow = s:themetime[i] - s:hshow * 60
    if len(s:hshow) == 1
      let s:hshow = ' ' . s:hshow
    endif
    if len(s:mshow) == 1
      let s:mshow = '0' . s:mshow
    endif
    put = s:hshow . ':' . s:mshow . '           ' .
          \ g:nd_themes[i][1] . ' (' . g:nd_themes[i][2] . ')'
  endfor
  1
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
