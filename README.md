# night-and-day

A **vim theme scheduler**. Divide your day into as many intervals as you like, assigning each interval it's own theme.

![](map.jpg)

## installation

If you don't already have a preferred plugin management system, consider trying [vim-plug](https://github.com/junegunn/vim-plug), which can be installed by running the following command in a terminal:

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

An example configuration:

```
let g:nd_themelist = ["solarized", "base16-default-light", "base16-default-dark", "solarized"]
let g:nd_themetime = ["8:00", "12:00", "17:00", "22:00"]
let g:nd_themeback = ["light", "light", "light", "dark"]
```

<table>
<tr>
<td> 0:00 -  1:00</td>
<td> 1:00 -  2:00</td>
<td> 2:00 -  3:00</td>
<td> 3:00 -  4:00</td>
<td> 4:00 -  5:00</td>
<td> 5:00 -  6:00</td>
<td> 6:00 -  7:00</td>
<td> 7:00 -  8:00</td>
<td> 8:00 -  9:00</td>
<td> 9:00 - 10:00</td>
<td>10:00 - 11:00</td>
<td>11:00 - 12:00</td>
<td>12:00 - 13:00</td>
<td>13:00 - 14:00</td>
<td>14:00 - 15:00</td>
<td>15:00 - 16:00</td>
<td>16:00 - 17:00</td>
<td>17:00 - 18:00</td>
<td>18:00 - 19:00</td>
<td>19:00 - 20:00</td>
<td>20:00 - 21:00</td>
<td>21:00 - 22:00</td>
<td>22:00 - 23:00</td>
<td>23:00 - 24:00</td>
</tr>
<tr>
<td colspan='8'>■■■ solarized ■■■<br>dark background</td>
<td colspan='4'>◦◦◦ base16-default-light ◦◦◦<br>light background\*</td>
<td colspan='5'>••• base16-default-dark •••<br>light background\*</td>
<td colspan='2'>□□□ solarized □□□<br>light background</td>
<td colspan='8'>■■■</td>
</tr>
</table>

## notes

This plugin incorporates the [vim-colorscheme-switcher](https://github.com/xolox/vim-colorscheme-switcher) by xolox.

Photo by [Neil Tackaberry](https://www.flickr.com/photos/23629083@N03/6904426431), licensed [CC BY-ND 2.0](https://creativecommons.org/licenses/by-nd/2.0/).

Map courtesy of [Wikimedia Commons](https://commons.wikimedia.org/wiki/File:Daylight_Map,_nonscientific_(0900_UTC).jpg).
