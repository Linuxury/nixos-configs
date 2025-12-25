# My Modular NixOS Flake Configuration

This repository contains my fully declarative, modular NixOS configuration using flakes.

- **NixOS unstable** (bleeding-edge)
- **Cosmic DE** as default (with cosmic-greeter)
- **Btrfs** with subvolumes and Snapper snapshots
- **Modular design** — hosts, modules, Home Manager
- **Multi-machine ready** — ThinkPad, Ryzen5900x, Ryzen5800x, ASUSTuff-A15, Alex machines, generic

## Hosts

- `ThinkPad` — my laptop (Cosmic + laptop power management)
- `Ryzen5900x` — my gaming desktop (Cosmic + gaming profile)
- `Ryzen5800x` — wife's desktop
- `ASUSTuff-A15` — wife's laptop
- `Alex-Desktop` / `Alex-Laptop` — kids
- `generic` — clean profile for friends/other machines

## Installation Guide (Fresh Install)

### 1. Boot NixOS Minimal ISO

Download the latest minimal ISO from https://nixos.org/download.html

Boot from USB, choose UEFI.

### 2. Enable SSH (for remote install)

```bash
passwd                     # set temporary root password
systemctl start sshd
ip addr show               # get your IP
```
SSH in from another machine:
```bash
ssh root@<ip>
```
### 3. Partition Disk (UEFI + Btrfs)
Replace /dev/nvme0n1 with your disk (use lsblk to confirm).
```bash
wipefs -a /dev/nvme0n1

parted /dev/nvme0n1 -- mklabel gpt
parted /dev/nvme0n1 -- mkpart primary fat32 1MiB 513MiB
parted /dev/nvme0n1 -- set 1 esp on
parted /dev/nvme0n1 -- mkpart primary 513MiB 100%

mkfs.fat -F 32 -n BOOT /dev/nvme0n1p1
mkfs.btrfs -f -L nixos /dev/nvme0n1p2
```
### 4. Create Subvolumes (including @swap — critical for Snapper)
```bash
mount /dev/nvme0n1p2 /mnt

btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@nix
btrfs subvolume create /mnt/@log
btrfs subvolume create /mnt/@snapshots
btrfs subvolume create /mnt/@swap   # ← Important for Snapper + swapfile

umount /mnt
```
### 5. Mount Subvolumes
```bash
mount -o subvol=@,compress=zstd:1,noatime,space_cache=v2 /dev/nvme0n1p2 /mnt

mkdir -p /mnt/{home,nix,var/log,.snapshots,swap,boot}
mount -o subvol=@home,compress=zstd:1,noatime,space_cache=v2 /dev/nvme0n1p2 /mnt/home
mount -o subvol=@nix,compress=zstd:1,noatime,space_cache=v2 /dev/nvme0n1p2 /mnt/nix
mount -o subvol=@log,compress=zstd:1,noatime,space_cache=v2 /dev/nvme0n1p2 /mnt/var/log
mount -o subvol=@snapshots,compress=zstd:1,noatime,space_cache=v2 /dev/nvme0n1p2 /mnt/.snapshots
mount -o subvol=@swap,noatime,space_cache=v2 /dev/nvme0n1p2 /mnt/swap
mount /dev/nvme0n1p1 /mnt/boot
```
### 6. Create Swapfile in @swap
```bash
btrfs filesystem mkswapfile --size 8g --uuid clear /mnt/swap/swapfile
swapon /mnt/swap/swapfile
```
### 7. Clone Repo & Install
```bash
nix-env -iA nixos.git
git clone https://github.com/Linuxury/nixos-configs.git /mnt/etc/nixos
cd /mnt/etc/nixos

# Install the desired host
nixos-install --flake .#ThinkPad          # your laptop
# nixos-install --flake .#Ryzen5900x      # gaming desktop
# nixos-install --flake .#Ryzen5800x      # wife's desktop
# nixos-install --flake .#ASUSTuff-A15    # wife's laptop
# nixos-install --flake .#Alex-Desktop    # kid's desktop
# nixos-install --flake .#Alex-Laptop     # kid's laptop
# nixos-install --flake .#generic         # friend/other machine
```
### 8. Reboot
```bash
umount -R /mnt
swapoff -a
reboot
```
### Post-Install Tasks
 - Change initial passwords:
```bash
passwd linuxury   # or babylinux / alex
```
 - Add Flathub for COSMIC Store (once):
```bash
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
```
 - Install latest Proton-GE:
   Launch COSMIC Store → ProtonUp-Qt → install latest GE

### Maintenance Aliases (Global for All Users)
```bash
rebuild   # sudo nixos-rebuild switch --flake ~/Documents/GitRepos/nixos-configs#<host>
update    # safe topgrade (nix, flatpak, git repos)
ff        # fastfetch
```
### Rollback
From GRUB: hold Shift/Esc → Advanced → older generation
Or:

```bash
sudo nixos-rebuild switch --rollback
```
