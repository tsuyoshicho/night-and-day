# night-and-day

A Vim plugin to automatically switch between your "day theme" and "night theme".

<img src="image.jpg" width="500">

## how it works

Some folks like to flip between a light theme during the day and a dark theme at night. When Vim is launched, night-and-day checks the time and loads the appropriate theme. It then runs in the background, ready to switch the theme if you happen to be running Vim as night falls, or as morning breaks.

## installation

### option A: manually

Download [`night-and-day.vim`](https://raw.githubusercontent.com/nightsense/night-and-day/master/plugin/night-and-day.vim) from this repository and place in directory `~/.vim/plugin/`.

### option B: using a plugin manager

For easy management of Vim plugins, try a plugin manager. With the [Vundle](https://github.com/VundleVim/Vundle.vim) plugin manager, for instance, just add `Plugin 'nightsense/night-and-day'` to the list of plugins in your `vimrc`, then run `VundleUpdate`. (To automatically keep plugins up to date with Vundle, add `vim +VundleUpdate +qall` to a startup script or cron job.)

## configuration

Configuring night-and-day involves setting variables in your `vimrc` file.

Day and night **themes** are set with `g:nd_day_theme` and `g:nd_night_theme`. For instance, to set your day theme to [seagull](https://github.com/nightsense/seabird) and your night theme to petrel:

~~~
let g:nd_day_theme = 'seagull'
let g:nd_night_theme = 'petrel'
~~~

Simply drop the above code into your `vimrc`, editing the theme names as needed. (If a theme is already defined in your `vimrc`, remove it.)

The **thresholds** of day and night are set with `g:nd_dawn_time` and `g:nd_dusk_time`. Each of these variables accepts an integer value from 0 to 23, representing hours on the 24-hour clock (0 is midnight, 1 is 1 AM, 23 is 11 PM). For instance, to have your day theme activate at 8AM and your night theme activate at 8PM:

~~~
let g:nd_dawn_time = 8
let g:nd_dusk_time = 20
~~~

8AM and 8PM are the default values; if you're happy with this timing, you can leave these settings out of your `vimrc`.

By default, Vim applies `background=light` to colourschemes. If you want to assign **`background=dark`**, you can use `nd_day_bgdark` and/or `nd_night_bgdark`, like so (0 means false, 1 means true):

~~~
let g:nd_day_bgdark    = 0
let g:nd_night_bgdark  = 1
~~~

Both settings are false by default; you only need to add these if you want to switch them to true. (If `background=` is already defined in your `vimrc`, remove it.)

So for instance, if you wanted to switch between [solarized](https://github.com/altercation/vim-colors-solarized) light during the day and solarized dark at night:

~~~
let g:nd_day_theme   = 'solarized'
let g:nd_night_theme = 'solarized'
let g:nd_night_bgdark = 1
~~~

## notes

Syntax highlighting is accidentally disabled for EasyMotion (and likely other plugins) upon colour scheme change, provided the colour scheme includes the (oft-present) command `hi clear`. For now, a patch fix is automatically applied by the plugin. Please [report](https://github.com/nightsense/night-and-day/issues) if this fix doesn't work for you, or if other issues are encountered.

Photo by [Neil Tackaberry](https://www.flickr.com/photos/23629083@N03/6904426431), licensed [CC BY-ND 2.0](https://creativecommons.org/licenses/by-nd/2.0/).
