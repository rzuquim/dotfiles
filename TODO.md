# Arch Install

- [x] System clock update
- [x] Partitioning drive
  - [x] UEFI
  - [x] ext4 main partition
  - [x] swap
  - [x] encryption (LUKS)

# Setup

- [x] basic
  - [x] timezone and hardware clock
  - [x] basic Locale configuration
  - [x] hostname and hosts
  - [x] keymap and console font
  - [x] root password prompt (interactive)
  - [x] create users
- [x] boot
  - [x] microcode
  - [x] initramfs (https://wiki.archlinux.org/title/Dm-crypt/Encrypting_an_entire_system#LVM_on_LUKS)
  - [x] bootloader (systemd-boot)
  - [ ] lts boot fallback
- [x] security
  - [x] sudo
  - [x] firewall (nftables)
  - [x] ssh (TOTP + pvt key only)
  - [ ] easy method to exchange public keys between machines
  - [ ] auditd
  - [ ] fail2ban
  - [ ] chkrootkit / rkhunter
  - [ ] lock down cron jobs and atd
- [x] network
  - [x] NetworkManager
  - [ ] local DNS server to resolve computer names
  - [ ] use systemd-networkd ?
- [ ] graphics
- [ ] audio
- [ ] wm
- [ ] tools
- [ ] code
- [ ] video
- [ ] gaming
- [ ] bluetooth
- [ ] locale
  - [ ] advanced Locale configuration (aka ç)
- [ ] monitoring (https://chatgpt.com/c/67f95efd-e364-8002-adca-957945f4aa39)
  - [ ] eBPF for process logging (bpftrace)
  - [ ] eBPF for network usage logging
  - [ ] resources usage
  - [ ] consolidation and reporting
  - [ ] grafana for details
  - [ ] rate limit

# Home

- [ ] Zoom
- [ ] Notes on screen
