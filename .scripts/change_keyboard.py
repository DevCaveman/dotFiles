#!/usr/bin/env python
# -*- coding: utf-8 -*-

''' 
    Toggles keyboard layout between BR and US when called
'''

import subprocess as sub

def change_keyboard():
    command = "setxkbmap -query | grep 'layout' | awk '{ print $2 }'"
    layout = str(sub.check_output(command, shell = True))
    layout = layout[2:-3]

    if layout == 'br':
        command = 'setxkbmap -model pc105 -layout us -variant intl'
        sub.os.system(command)
    elif layout == 'us':
        command = 'setxkbmap -model pc105 -layout br'
        sub.os.system(command)
    else:
        print('EROR - unknow layout {}'.format(layout))

    # calling xmodmap
    sub.os.system('$HOME/.scripts/reload-keys')

if __name__ == '__main__':
    change_keyboard()

