# TODO

## Install

- [ ] when executing `.install.sh` on dotfiles repo (already installed) just ensure apps are installed
- [ ] use yubikey instead of passphrase to encrypt / decrypt with LUKS
- [ ] on `./install/07_crypto_storage.sh` fix the starting index of the cryptlvm device
- [x] install browsers (AUR)
- [x] install bluetuith (AUR)
- [x] configure browser
  - [x] smart script to open browser
- [ ] file explorer
- [x] writing
  - [x] note taking
  - [x] studying
- [ ] video conf (zoom)
  - [x] screen sharing
  - [ ] screen anotations
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
- [ ] Nikto → for deeper web vulnerability scans
- [ ] Lynis or OpenVAS → full system security audits
- [ ] lock down cron jobs and atd
- [ ] automatic default output device (hdmi, headset, etc)
- [ ] input device (mic, etc)
- [x] multiple monitors
  - [x] shortcut to execute `monitors_and_workspaces.sh` (maybe with a dmenu with multiple uncommon actions)
  - [ ] run `monitors_and_workspaces.sh` whenever a monitor is plugged / unplugged
- [x] steam available only for `fun` user
- [ ] periodically run diagnostics and detect WARNS / errors on logs (nvim included)
- [x] advanced locale configuration (aka ç)
- [ ] `monitoring` eBPF for process logging (bpftrace)
- [ ] `monitoring` eBPF for network usage logging
- [ ] `monitoring` resources usage
- [ ] `monitoring` consolidation and reporting
  - `sudo dmesg -T | grep --invert-match 'segfault|error|gpu|oom'`
- [ ] `monitoring` grafana for details
- [ ] `monitoring` rate limit
- [ ] periodically suggest updating packages
  - [ ] `zsh`: periodically updates plugins
- [x] printscreen
- [x] input management (keyboard layout)
- [x] disable laptop keyboard

## Config

- [ ] use yubikey to store SSH private keys
- [x] librewolf config on dotfiles
- [ ] xdg-open link should change workspace to web
- [ ] `hyprland`: multi monitor
  - [x] styling title bar
  - [x] test if i can actually find out the classes in firefox
  - [x] style sidebar
- [x] `hyprland`: wallpaper (bg-random.sh)
- [x] `hyprland`: notification
- [x] `hyprland`: lock screen
- [ ] `hyprland`: idle detection (and lock) - can be disabled like caffeine
- [x] `hyprland`: clipboard manager
- [x] `hyprland`: magnifier
- [ ] `hyprland`: draw on screen
- [ ] `hyprland`: authentication agent (https://wiki.hyprland.org/Useful-Utilities/Must-have/#authentication-agent)
- [ ] `hyprland`: color picker
- [ ] `hyprland`: media buttons
- [x] `waybar`: style
  - [ ] weather
  - [ ] cpu / mem / disk
  - [ ] notification
- [ ] `weather`
  - [ ] systemd script to periodically write weather in /tmp/
  - [ ] full weather info (specially rain probability)
  - [ ] weather info on waybar
- [ ] customize mangohub shortcuts
- [ ] `zsh`: keyboard driven URL navigation
- [x] `zsh`: navigation with arrows in insert mode

## Server

- [ ] local DNS server to resolve computer names

## Bugs

- [x] `waybar` show/hide:
  - [x] when closing the last open window ensure waybar is showing
  - [x] when going to a workspace show if not full screen / hide if full screen
- [ ] hyprland crashing:
  - [x] USB bluetooth dongle (after removing it stopped crashing)
  - [ ] amd page fault
    - https://unix.stackexchange.com/questions/756281/kernel-6-5-2-seems-to-have-amdgpu-crash-on-no-retry-page-fault
    - amdgpu.gttsize=4096
    - amdgpu.mcbp=0
- [x] nftables blocking internal IPv6 DHCP
- [ ] kb-disable not working on zavell
- [x] fonts not installing on zavell

## Test

- [ ] test on machine without /storage
- [ ] test on machine with multiple nvmes drivers
- [ ] lts boot fallback
- [ ] nvidia support
- [x] amd support
- [x] working triple A game (GoW)
- [ ] tmux
- [ ] bluetooth
- [ ] `hyprland`: electron support (https://wiki.hyprland.org/Getting-Started/Master-Tutorial/#force-apps-to-use-wayland)
