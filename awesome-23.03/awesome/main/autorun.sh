#!/usr/bin/env bash

function run {
  if ! pgrep -f $1 ;
  then
    $@&
  fi
}

# compositor
run picom --experimental-backends

# auth
run /usr/libexec/polkit-gnome-authentication-agent-1

# fcitx5
run fcitx5 -d

# clash
run /opt/clash-for-windows-bin/cfw

#vnc
run x0vncserver -rfbauth /home/archfeh/.vnc/passwd
