# TODO

## Install

- [ ] use yubikey instead of passphrase to encrypt / decrypt with LUKS
- [ ] on `./install/07_crypto_storage.sh` fix the starting index of the cryptlvm device
- [ ] install browsers (AUR)
- [ ] install bluetuith (AUR)
- [ ] screen sharing
- [ ] screen anotations
- [ ] video conf
- [ ] obs and streaming stuff
- [ ] docker
- [ ] chats: telegram, wapp, discord

## Setup

- [ ] only prompt for passphrase if any of the basic lists of users (or root) don't already have a password
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
- [ ] steam available only for `fun` user
- [ ] periodically run diagnostics and detect WARNS / errors on logs (nvim included)
- [ ] advanced Locale configuration (aka ç)
- [ ] `monitoring` eBPF for process logging (bpftrace)
- [ ] `monitoring` eBPF for network usage logging
- [ ] `monitoring` resources usage
- [ ] `monitoring` consolidation and reporting
- [ ] `monitoring` grafana for details
- [ ] `monitoring` rate limit

## Config

- [ ] use yubikey to store SSH private keys
- [ ] librewolf config on dotfiles
- [ ] `hyprland`: status bar
- [ ] `hyprland`: multi monitor
- [ ] `hyprland`: wallpaper (bg-random.sh)
- [ ] `hyprland`: notificatioon
- [ ] `hyprland`: lock screen
- [ ] `hyprland`: clipboard manager
- [ ] `hyprland`: electron support (https://wiki.hyprland.org/Getting-Started/Master-Tutorial/#force-apps-to-use-wayland)
- [ ] `hyprland`: authentication agent (https://wiki.hyprland.org/Useful-Utilities/Must-have/#authentication-agent)
- [ ] `hyprland`: color picker
- [ ] steamcmd
- [ ] customize mangohub shortcuts
- [ ] `zsh`: keyboard driven URL navigation
- [ ] `zsh`: periodically updates plugins
- [ ] input locale management

## Server

- [ ] local DNS server to resolve computer names

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
