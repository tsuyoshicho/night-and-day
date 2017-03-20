" get variables
let g:nd_day_theme      = get(g:, 'nd_day_theme', 'default')
let g:nd_day_bgdark     = get(g:, 'nd_day_bgdark', 0)
let g:nd_night_theme    = get(g:, 'nd_night_theme', 'default')
let g:nd_night_bgdark   = get(g:, 'nd_night_bgdark', 0)
let g:nd_dawn_time      = get(g:, 'nd_dawn_time', 8)
let g:nd_dusk_time      = get(g:, 'nd_dusk_time', 20)
let g:nd_current_theme  = ''
let g:nd_current_bgdark = ''

" EasyMotion highlighting fix
function! NightdayPost()
  silent! so ~/.vim/bundle/vim-easymotion/autoload/EasyMotion/highlight.vim
endfunction

" theme switching function
function! Nightday()
  if strftime("%H") < g:nd_dawn_time || strftime("%H") + 1 > g:nd_dusk_time
    if g:nd_current_theme != g:nd_night_theme
      exec 'colorscheme ' . g:nd_night_theme
      let g:nd_current_theme = g:nd_night_theme
      call NightdayPost()
    endif
    if g:nd_current_bgdark != g:nd_night_bgdark
      if g:nd_night_bgdark == 1
        exec 'set background=dark'
        call NightdayPost()
      endif
    endif
  else
    if g:nd_current_theme != g:nd_day_theme
      exec 'colorscheme ' . g:nd_day_theme
      let g:nd_current_theme = g:nd_day_theme
      call NightdayPost()
    endif
    if g:nd_current_bgdark != g:nd_day_bgdark
      if g:nd_day_bgdark == 1
        exec 'set background=dark'
        call NightdayPost()
      endif
    endif
  endif
endfunction

call Nightday()
autocmd CursorHold * call Nightday()
