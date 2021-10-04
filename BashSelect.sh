
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
  function printOptions () #printing the different options
  {
  it=$( echo $1)
  for i in ${!OPTIONS[*]}; do
    if [[ "$i" == "$it" ]]; then
      tput rev
      printf '%4d ) %s\n' $i "${OPTIONS[$i]}"
      tput sgr0
    else
      printf '%4d ) %s\n' $i "${OPTIONS[$i]}"
    fi
  done
  }

  tput civis
  it=0

  printOptions $it

  while true; do #loop through array to capture every key press until enter is pressed
    #capute key input
    read -rsn1 key
    escaped_char=$( printf "\u1b" )
    if [[ $key == $escaped_char ]]; then
        read -rsn2 key
    fi
    tput cuu ${#OPTIONS[@]} && tput ed
    tput sc

    #handle key input
    case $key in
        '[A' | '[C' )
            it=$(($it-1));;
        '[D' | '[B')
            it=$(($it+1));;
        '' )
            tput cnorm
            return $it && exit;;
    esac
    #manage that you can't select something out of range
    min_len=0
    farr_len=$(( ${#OPTIONS[@]}-1))
    if [[ "$it" -lt "$min_len" ]]; then
      it=$(( ${#OPTIONS[@]}-1 ))
    elif [[ "$it" -gt "$farr_len"  ]]; then
      it=0
    fi

    printOptions $it

  done

}
