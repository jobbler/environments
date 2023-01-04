This is my configuration and scripts for my Sway desktop environment.

bash
  Contains bash related items like functions I use.

bin
  These are the executables, etc that go in your path. e.g. $HOME/bin

sway
  This is the sway configuration. Goes under $HOME/.config/sway

waybar
  This is the waybar configuration. Goes under $HOME/.config/waybar

Packages to install:
wofi
ffmpeg
i3status-rs
swayidle
swaylock
sway
swaybg
waybar
mako
gnome-keyring
polkit-gnome
pulseaudio
pulseaudio-utils
pulseaudio-module-bluetooth
pulseaudio-module-x11
pulseaudio-module-gconf
alsa-plugins-pulseaudio
light
Xdialog
kanshi
wl-clipboard
clipman
pactl
flashfocus
wf-recorder

Systemd
https://github.com/swaywm/sway/wiki/Systemd-integration

~/.config/systemd/user/sway-session.target
~~~
[Unit]
Description=sway compositor session
Documentation=man:systemd.special(7)
BindsTo=graphical-session.target
Wants=graphical-session-pre.target
After=graphical-session-pre.target
~~~

Add to end of sway config (or /etc/sway/config.d/10-systemd)
~~~
exec "systemctl --user import-environment; systemctl --user start sway-session.target"
~~~


log sway output 
If you'd like sway's output to be handled by journald (like a systemd service), you can used systemd-cat for this:
~~~
exec systemd-cat --identifier=sway sway
~~~


systemd Waybar
~/.config/systemd/user/waybar.service or /etc/systemd/user/waybar.service
~~~
[Unit]
Description=Highly customizable Wayland bar for Sway and Wlroots based compositors.
Documentation=https://github.com/Alexays/Waybar/wiki/
PartOf=graphical-session.target

[Service]
Type=simple
ExecStart=/usr/bin/waybar

[Install]
WantedBy=sway-session.target
~~~
Enable and start the service with systemctl --user enable --now waybar.


systemd swayidle
~~~
[Unit]
Description=Idle manager for Wayland
Documentation=man:swayidle(1)
PartOf=graphical-session.target

[Service]
Type=simple
ExecStart=/usr/bin/swayidle -w \
            timeout 300 'swaylock -f -c 000000' \
            timeout 600 'swaymsg "output * dpms off"' \
                resume 'swaymsg "output * dpms on"' \
            before-sleep 'swaylock -f -c 000000'

[Install]
WantedBy=sway-session.target
~~~


environment vars
Loading environment variables from environment.d

Use case: You want to abide by upcoming environment.d way of managing your environment variables

Anti use-case: You don't find a good enough reason to abide by environment.d's way.

Handily enough, the environment.d's generator returns plain KEY=VALUE pairs, which we can eval-export line by line. You can put something around those lines in your sway startup wrapper script.


systemd kanshi
~~~
systemd.user.services.kanshi = {
    description = "Kanshi output autoconfig ";
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    serviceConfig = {
      # kanshi doesn't have an option to specifiy config file yet, so it looks
      # at .config/kanshi/config
      ExecStart = ''
        ${pkgs.kanshi}/bin/kanshi
      '';
      RestartSec = 5;
      Restart = "always";
    };
  };
~~~

