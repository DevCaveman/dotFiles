#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# To use it, ensure your ~/.i3status.conf contains this line:
#     output_format = "i3bar"
# in the 'general' section.
# Then, in your ~/.i3/config, use:
#     status_command i3status | ~/.config/i3status/contrib/wrapper.py
# In the 'bar' section.

import subprocess as sub
import json


def get_output(command : str) -> str:
    ''' This function execute a given command in the shell and return the output.'''
    return str(sub.check_output(command, shell = True))[2:-3]


def get_percentage() -> int:
    ''' Return the battery charge level. '''
    return int(get_output("acpi -b | awk '{ print $4 }'")[:-2])


def charge_animation(bat_percentage : int = 999) -> str:
    ''' Return the battery charge animation based on how many times it was called. '''
    charge_animation.count += 1

    if charge_animation.count == 1:
        status = ' \uf0e7 \uf243 ' + str(bat_percentage) + '% '
    elif charge_animation.count == 2:
        status = ' \uf0e7 \uf242 ' + str(bat_percentage) + '% '
    elif charge_animation.count == 3:
        charge_animation.count = 0
        status = ' \uf0e7 \uf241 ' + str(bat_percentage) + '% '
    else:
        charge_animation.count = 0
        status = ' ErrCA'
    return status


def discharging_animation(bat_percentage : int = 999) -> str:
    ''' Return the discharging animation based on battery charge level. '''
    if bat_percentage >= 90:
        status = ' \uf240 ' + str(bat_percentage) + '% '
    elif bat_percentage >= 70:
        status = ' \uf241 ' + str(bat_percentage) + '% '
    elif bat_percentage >= 50:
        status = ' \uf242 ' + str(bat_percentage) + '% '
    elif bat_percentage >= 30:
        status = ' \uf243 ' + str(bat_percentage) + '% '
    elif bat_percentage >= 15:
        status = ' \uf244 ' + str(bat_percentage) + '% '
    else:
        status = ' \uf071 ' + str(bat_percentage) + '% '
    return status


def get_energy_status():
    ''' Return the energy status. '''
    # Is battery present?
    bat_present = get_output("acpi -b") is not ''
    if bat_present:
        # Is AC Adapter plugged?
        ac_plugged = get_output("acpi -a | awk '{ print $3 }'") == "on-line"
        if ac_plugged:
            # Is it charging?
            charging = get_output("acpi | awk '{ print $3 }'") != "Full,"
            if charging:
                return charge_animation(get_percentage())
            else:
                # Full
                return ' \uf0e7 \uf240 100% '
        else:
            return discharging_animation(get_percentage()) 
    elif not bat_present:
        return ' \uf0e7 \uf05e '
    else:
        return ' ErrGE '


def get_keyboard():
    ''' Return the keyboard layout. '''
    out_put = get_output("setxkbmap -query | grep 'layout' | awk '{ print $2 }'")
    return ' \uf11c ' + out_put.upper() + ' '


def get_caps():
    ''' Return the state off capslock(on, off). '''
    caps_is_on = get_output("xset q | grep 'Caps' | awk '{ print $4 }'") == "on"
    if caps_is_on:
        return ' \uf205 Caps '
    else:
        return ' \uf204 Caps '


def print_line(message):
    """ Non-buffered printing to stdout. """
    sub.sys.stdout.write(message + '\n')
    sub.sys.stdout.flush()


def read_line():
    """ Interrupted respecting reader for stdin. """
    # try reading a line, removing any extra whitespace
    try:
        line = sub.sys.stdin.readline().strip()
        # i3status sends EOF, or an empty line
        if not line:
            sub.sys.exit(3)
        return line
    # exit on ctrl-c
    except KeyboardInterrupt:
        sub.sys.exit()


if __name__ == '__main__':
    # Init count animation.
    charge_animation.count = 0

    # Skip the first line which contains the version header.
    print_line(read_line())

    # The second line contains the start of the infinite array.
    print_line(read_line())

    while True:
        line, prefix = read_line(), ''
        # ignore comma at start of lines
        if line.startswith(','):
            line, prefix = line[1:], ','

        j = json.loads(line)
        # insert information into the start of the json, but could be anywhere
        # CHANGE THIS LINE TO INSERT SOMETHING ELSE
        j.insert(0, {'full_text' : '%s' % get_energy_status()})
        j.insert(0, {'full_text' : '%s' % get_caps()})
        j.insert(0, {'full_text' : '%s' % get_keyboard()})
        # and echo back new encoded json
        print_line(prefix+json.dumps(j))
