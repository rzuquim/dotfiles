# TODO

## Install

- [ ] when executing `.install.sh` on dotfiles repo (already installed) just ensure apps are installed
- [ ] on `./install/07_crypto_storage.sh` fix the starting index of the cryptlvm device
- [x] install browsers (AUR)
- [x] install bluetuith (AUR)
- [x] configure browser
  - [x] smart script to open browser
- [x] file explorer
  - [ ] start on work context
  - [ ] n - for fzf navigation (like in terminal)
  - [ ] w - for workspace navigation (like in terminal)
  - [ ] file picker integration (eg: use in browser)?
- [x] writing
  - [x] note taking
  - [x] studying
- [x] sudo pacman -S archlinux-keyring
- [ ] video conf (zoom)
  - [x] screen sharing
  - [ ] screen anotations
- [ ] streaming
  - [ ] obs
  - [ ] excalidraw
- [x] docker
- [ ] git-crypt
- [x] presenterm
- [x] mermaid-cli
- [x] art
  - [x] install libresprite
  - [x] install gimp
  - [x] install krita
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
- [ ] gpg-keys (reference: finance repo)
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
  - [ ] `sudo dmesg -T | grep --invert-match 'segfault|error|gpu|oom'`
- [ ] `monitoring` grafana for details
- [ ] `monitoring` rate limit
- [ ] periodically suggest updating packages
  - [ ] `zsh`: periodically updates plugins
- [x] printscreen
- [x] input management (keyboard layout)
- [x] disable laptop keyboard
- [ ] nft log limits to avoid DOS flooding log files
- [x] sudo pacman-key --init
- [x] sudo pacman-key --populate archlinux
- [ ] streaming
  - [ ] obs
  - [ ] excalidraw
- [ ] yubikey (both keys)
  - [x] google
  - [x] amazon
  - [ ] LUKS
  - [ ] GPG @ pvt repos
  - [ ] GPG @ git signature

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
- [x] `hyprland`: do not swallow npm / cargo / etc. (toggle command was the best option)
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
- [ ] auto-commit / push notes repository on startup (daily)

## Server

- [ ] media-server
  - [x] remove `qbittorrent` installed locally
  - [x] `jellyfin` server
  - [x] `jellyfin` client on tv
  - [ ] `jellyfin` config
  - [ ] `qbittorrent` password on config
  - [ ] move previously downloaded files from `/me/Downloads/torrent` into `storage` partition
  - [ ] `radarr`
  - [ ] `sonarr`
  - [ ] `lidarr`
  - [ ] `bazarr`
  - [ ] `prowlarr`
  - [ ] use vpn

## Bugs

- [x] `waybar` show/hide:
  - [x] when closing the last open window ensure waybar is showing
  - [x] when going to a workspace show if not full screen / hide if full screen
- [ ] hyprland crashing:

  - [x] USB bluetooth dongle (after removing it stopped crashing)
  - [ ] amd page fault

    - amdgpu.gttsize=4096
    - amdgpu.mcbp=0
    - current unstable boot config: `options cryptdevice=UUID=329dfb36-eac5-4d67-8edb-3ce1c35f4001:cryptlvm0 root=/dev/mapper/vg0-root quiet rw pcie_aspm=off amdgpu.gttsize=4096 amdgpu.mcbp=0`
    - https://unix.stackexchange.com/questions/756281/kernel-6-5-2-seems-to-have-amdgpu-crash-on-no-retry-page-fault

  - [ ] pin the card in its high‑perf power state

  ```
    Clock/voltage hopping can also provoke the fault. After boot (or in a udev rule) force the DPM level to high:
    echo high | sudo tee /sys/class/drm/card0/device/power_dpm_force_performance_level
    (Substitute card1 if your dGPU is card1.) Some users stay crash‑free once the clocks no longer change
  ```

- [x] nftables blocking internal IPv6 DHCP
- [ ] better kb-disable (not working on zavell)
      toggle the notebook keyboard using hyprland cmds to set device:active = Off / On
- [x] fonts not installing on zavell
- [ ] WIN-O - for notes, is not opening on the context of the repository (in vim `git changed files` cmd is not working)
- [ ] disable ipv6 for docker `/etc/docker/daemon.json`

```json
{
  "ipv6": false
}
```

## Test

- [ ] test on machine without /storage
- [ ] test on machine with multiple nvmes drivers
- [ ] lts boot fallback
- [x] nvidia support
- [x] amd support
- [x] working triple A game (GoW)
- [ ] tmux
- [x] bluetooth
- [ ] `hyprland`: electron support (https://wiki.hyprland.org/Getting-Started/Master-Tutorial/#force-apps-to-use-wayland)

## Remove

- [ ] review installed packages to remove unused
  - [ ] dotnet sdk
  - [ ] obsidian
