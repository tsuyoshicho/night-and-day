# night-and-day

A **vim theme scheduler**. Divide your day into as many intervals as you like, assigning each interval it's own theme.

![](map.jpg)

## installation

If you don't have a preferred approach to **plugin management**, consider trying [vim-plug](https://github.com/junegunn/vim-plug), which can be installed with:

~~~
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
~~~

To **install night-and-day**, add the following to the top of `vimrc`:

~~~
call plug#begin('~/.vim/plugged')
Plug 'nightsense/night-and-day'
call plug#end()
~~~

Then, within vim, run `PlugUpdate`.

## configuration

You'll need to add **three lines** to `vimrc`. Each line defines a list, and each list must contain the same number of items.

list           | description
:-------------:|:----------:
g:nd_themelist | the **name** of each theme (as used by the vim command `colorscheme`); list them in chronological order, starting from midnight
g:nd_themetime | the **starting time** for each theme (that is, the time you want the corresponding theme to become active) in `HH:MM` 24-hour format (you can drop the leading zero on single-digit hours)
g:nd_themeback | the **background state** for each theme, which is either `light` or `dark`; the former is the default setting, and is expected by many themes that don't feature background toggling

This example configuration reflects the schedule illustrated on the world map above:

```
let g:nd_themelist = ["base16-default-light", "solarized", "solarized"]
let g:nd_themetime = ["4:00", "11:00", "18:00"]
let g:nd_themeback = ["light", "light", "dark"]
```

## notes

This plugin incorporates the [vim-colorscheme-switcher](https://github.com/xolox/vim-colorscheme-switcher) by xolox.

Photo by [Neil Tackaberry](https://www.flickr.com/photos/23629083@N03/6904426431), licensed [CC BY-ND 2.0](https://creativecommons.org/licenses/by-nd/2.0/).

Map courtesy of [Wikimedia Commons](https://commons.wikimedia.org/wiki/File:Daylight_Map,_nonscientific_(0900_UTC).jpg).
