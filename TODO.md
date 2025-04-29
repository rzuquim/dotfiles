# TODO

## Install

- [ ] when executing `.install.sh` on dotfiles repo (already installed) just ensure apps are installed
- [ ] use yubikey instead of passphrase to encrypt / decrypt with LUKS
- [ ] on `./install/07_crypto_storage.sh` fix the starting index of the cryptlvm device
- [x] install browsers (AUR)
- [x] install bluetuith (AUR)
- [x] configure browser
  - [x] smart script to open browser
- [ ] screen sharing
- [ ] screen anotations
- [ ] video conf
- [ ] obs and streaming stuff
- [ ] docker
- [ ] chats
  - [x] telegram
  - [x] wapp
  - [ ] discord

## Setup

- [x] when executing `.setup.sh` on dotfiles repo already we should not clone into `/tmp/dotfiles/`
- [x] only prompt for passphrase if any of the basic lists of users (or root) don't already have a password
- [ ] check if passphrase prefix matches the LUKS one
- [ ] ssh TOTP
- [ ] sudo TOTP
- [ ] cannot sudo over ssh
- [ ] auditd
- [ ] fail2ban
- [ ] chkrootkit / rkhunter
- [ ] lock down cron jobs and atd
- [ ] automatic default output device (hdmi, headset, etc)
- [ ] input device (mic, etc)
- [ ] multiple monitors
- [x] steam available only for `fun` user
- [ ] periodically run diagnostics and detect WARNS / errors on logs (nvim included)
- [ ] advanced Locale configuration (aka ç)
- [ ] `monitoring` eBPF for process logging (bpftrace)
- [ ] `monitoring` eBPF for network usage logging
- [ ] `monitoring` resources usage
- [ ] `monitoring` consolidation and reporting
- [ ] `monitoring` grafana for details
- [ ] `monitoring` rate limit
- [ ] periodically suggest updating packages
  - [ ] `zsh`: periodically updates plugins
- [x] printscreen

## Config

- [ ] use yubikey to store SSH private keys
- [ ] librewolf config on dotfiles
- [ ] `hyprland`: runner (replace wofi with something more customizable or contribute)
- [ ] `hyprland`: multi monitor
- [x] `hyprland`: wallpaper (bg-random.sh)
- [ ] `hyprland`: notification
- [x] `hyprland`: lock screen
- [ ] `hyprland`: clipboard manager (https://www.reddit.com/r/unixporn/comments/1jxg7wx/hyprland_clipse_gui_clipboard_manager/?share_id=nUEHhyBv-7xMwFSwvNkTD&utm_medium=ios_app&utm_name=iossmf&utm_source=share&utm_term=14)
- [x] `hyprland`: magnifier
- [ ] `hyprland`: draw on screen
- [ ] `hyprland`: electron support (https://wiki.hyprland.org/Getting-Started/Master-Tutorial/#force-apps-to-use-wayland)
- [ ] `hyprland`: authentication agent (https://wiki.hyprland.org/Useful-Utilities/Must-have/#authentication-agent)
- [ ] `hyprland`: color picker
- [ ] `hyprland`: media buttons
- [x] `waybar`: style
  - [ ] no batery on PC
  - [ ] notify battery info on click
  - [ ] wifi
  - [ ] weather
  - [ ] cpu / mem / disk
- [ ] `weather`
  - [ ] systemd script to periodically write weather in /tmp/
  - [ ] full weather info (specially rain probability)
  - [ ] weather info on waybar
- [ ] customize mangohub shortcuts
- [ ] `zsh`: keyboard driven URL navigation
- [x] `zsh`: navigation with arrows in insert mode
- [ ] input locale management

## Server

- [ ] local DNS server to resolve computer names

## Bugs

- [x] `waybar` show/hide:
  - [x] when closing the last open window ensure waybar is showing
  - [x] when going to a workspace show if not full screen / hide if full screen
- [ ] hyprland crashing:
  - [ ] USB bluetooth dongle (after removing it stopped crashing)
  - errors on: `sudo dmesg -T | grep --invert-match 'segfault|error|gpu|oom'`
  - PCIe Bus Error: severity=Correctable, type=Physical Layer (Receiver ID)
  - device [8086:06b0] error status/mask=00000001/00002000
- [ ] nftables blocking internal IPv6 DHCP
  - nftables input drop: IN=eno1 OUT= MACSRC=d8:c6:78:83:ed:80 MACDST=18:c0:4d:f1:76:66 MACPROTO=86dd

## Test

- [ ] test on machine without /storage
- [ ] test on machine with multiple nvmes drivers
- [ ] lts boot fallback
- [ ] nvidia support
- [ ] amd support
- [ ] working triple A game (GoW)
- [ ] tmux
- [ ] bluetooth
- [ ] input management (keyboard layout)
