#!/bin/sh

# /etc/X11/xinit/xinitrc
#
# global xinitrc file, used by all X sessions started by xinit (startx)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
        [ -x "$f" ] && . "$f"
          done
            unset f
fi
# invoke global X session script
#. /etc/X11/Xsession

#exec openbox-session

#exec $HOME/.xinit.d/subtle

#exec $HOME/.xinit.d/dwm

#exec $HOME/.xinit.d/i3

#exec xfce4-session

exec $HOME/.xinit.d/bspwm

#exec $HOME/.xinit.d/spectrwm
