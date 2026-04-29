# Linux Notes

## Switch audio on PC

`/usr/bin/amixer -c 0 sset "Auto-Mute Mode" Disabled
`

## Fix dummy audio issues on a laptop

`
su
echo "options snd-intel-dspcfg dsp_driver=1" > /etc/modprobe.d/alsa.conf
`

<https://4pda.to/forum/index.php?showtopic=990302&st=3900#entry120084235>

## Shadowsocks

ss://Y2hhY2hhMjAtaWV0Zi1wb2x5MTMwNTpsdGh0ZHR5bXJmbGp2NDQ@proxy.dimania.ru:63664#proxy

## Stremio

get aur/stremio

copy .desktop to local dir via:
`cp /usr/share/applications/com.stremio.stremio.desktop ~/.local/share/applications/`

change exec lines in local desktop file to:
`Exec=env XDG_CURRENT_DESKTOP=Unity env QT_QPA_PLATFORM=xcb stremio %f ALL_PROXY="socks5://127.0.0.1:1080"
TryExec=env XDG_CURRENT_DESKTOP=Unity QT_QPA_PLATFORM=xcb stremio ALL_PROXY="socks5://127.0.0.1:1080"`

env XDG_CURRENT_DESKTOP=Unity - use libayatana-appindicator to display icons (systray)
env QT_QPA_PLATFORM=xcb stremio %f - niri+noctalia cachyos doesnt open some apps by default
ALL_PROXY="socks5://127.0.0.1:1080 - proxy all traffic

## KDE Plasma 6 Stuff

### Look & Feel

**Global Theme** - Vivid-Magna-Dark Global 6
**Colors** - Dark&Purple (stow kde)
**Window Decorations** - Infinity-Dark-Aurorae-6
**Icons** - Slot-Dark-Icons
**Cursors** - Flatbed Cursors original Black
**Splash Screen** - Rem
**Login Screen (SDDM)** - Where is my SDDM theme?
**Font** - Montserrat Alternates
> IgnorePkg = ttf-montserrat should be added to pacman.conf in order to exclude aur-font updates to montserrat-ttf, which is an alternative font from a core lib.
