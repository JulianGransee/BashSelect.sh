
#    Copyright (C) 2021  Julian G.
#
#    This program is free software; you can redistribute it and/or modify
#    it under the terms of the GNU General Public License 2 as published by
#    the Free Software Foundation.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License 2 for more details.
#
#    You should have received a copy of the GNU General Public License 2 along
#    with this program; if not, write to the Free Software Foundation, Inc.,
#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

#!/bin/bash

function bashSelect() {
  function printOptions() { # printing the different options
    it=$1
    for i in "${!OPTIONS[@]}"; do
      if [[ "$i" -eq "$it" ]]; then
        echo -e "\033[7m  $i) ${OPTIONS[$i]} \033[0m"
      else
        echo "  $i) ${OPTIONS[$i]}"
      fi
    done
  }

  trap 'echo -ne "\033[?25h"; exit' SIGINT SIGTERM
  echo -ne "\033[?25l"
  it=0

  printOptions $it

  while true; do # loop through array to capture every key press until enter is pressed
    # capture key input
    read -rsn1 key
    if [[ $key == $'\x1b' ]]; then
      read -rsn2 key
    fi

    echo -ne "\033[${#OPTIONS[@]}A\033[J"

    # handle key input
    case $key in
      '[A' | '[C') ((it--));; # up or right arrow
      '[B' | '[D') ((it++));; # down or left arrow
      '')
        echo -ne "\033[?25h"
        return "$it"
        ;;
    esac

    # manage that you can't select something out of range
    min_len=0
    max_len=$(( ${#OPTIONS[@]} - 1 ))
    if [[ "$it" -lt "$min_len" ]]; then
      it=$max_len
    elif [[ "$it" -gt "$max_len" ]]; then
      it=$min_len
    fi

    printOptions $it

  done

}