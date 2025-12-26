# My Modular NixOS Flake Configuration

This repository contains my **fully declarative, modular NixOS setup** using flakes.
It is designed to be **reliable**, **easy to reinstall**, and **simple enough for family use**.

## Highlights

- **NixOS unstable**
- **COSMIC DE as default**
- Optional KDE, GNOME, Hyprland, Niri
- **Btrfs with subvolumes + Snapper**
- **Disk labels (not UUIDs)** for stability
- **SSH-first installation**
- **Multi-host support**

## Hosts

- `ThinkPad` — primary laptop
- `Ryzen5900x` — gaming desktop
- `Ryzen5800x` — wife’s desktop
- `ASUSTuff-A15` — wife’s laptop
- `Alex-Desktop`, `Alex-Laptop` — kid
- `generic` — fallback / test machine


# Installation Guide (Fresh Install)

This guide assumes:
- NixOS **Minimal ISO**
- **UEFI**
- Installation done **over SSH**
- Wi-Fi may be required

Follow steps in order.


## 1. Boot NixOS Minimal ISO

- Boot the **Minimal ISO**
- Select **UEFI**
- Wait for the root shell


## 2. Improve Console Readability (recommended)

Set a large, readable font:

```bash
setfont ter-118b
```

## 3. Network Setup

Check if network already works
```bash
ping -c 3 nixos.org
```
If this works, skip Wi-Fi setup.

Wi-Fi Setup (if needed)
```bash
nmtui
```
Steps:

 - Select Activate a connection
 - Choose your Wi-Fi interface
 - Pick your network SSID
 - Enter password
 - Exit and verify:

Verify:
```bash
ping -c 3 nixos.org
```
Do not continue until networking works.


## 4. Enable SSH (Remote Install)
Set a temporary root password:
```bash
sudo passwd root                  
```
Start SSH:
```bash
sudo systemctl start sshd
```
Find IP address:
```bash
ip addr             
```
From another computer:
```bash
ssh root@<IP_ADDRESS>
```
From now on, continue over SSH.

## 5. Identify Disk
```bash
lsblk
```
Examples:
 - NVMe: /dev/nvme0n1
 - SATA: /dev/sda
   
Adjust commands if your disk differs.

## 6. Partition Disk (UEFI)
Replace /dev/nvme0n1 with your disk (use lsblk to confirm).
```bash
wipefs -a /dev/nvme0n1

parted /dev/nvme0n1 -- mklabel gpt
parted /dev/nvme0n1 -- mkpart ESP fat32 1MiB 513MiB
parted /dev/nvme0n1 -- set 1 esp on
parted /dev/nvme0n1 -- mkpart primary 513MiB 100%
```
## 7. Format with Labels (Important)

Labels are more stable than UUIDs.
```bash
mkfs.fat -F32 -n EFI /dev/nvme0n1p1
mkfs.btrfs -f -L nixos /dev/nvme0n1p2  # Create main Btrfs volume
```

Verify:
```bash
lsblk -f
```
You should see:
 - EFI
 - nixos

## 8. Create Btrfs Subvolumes
```bash
mount /dev/disk/by-label/nixos /mnt

btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@nix
btrfs subvolume create /mnt/@log
btrfs subvolume create /mnt/@snapshots
btrfs subvolume create /mnt/@swap

umount /mnt
```

## 9. Mount Subvolumes
```bash
mount -o subvol=@,compress=zstd:1,noatime /dev/disk/by-label/nixos /mnt

mkdir -p /mnt/{home,nix,var/log,.snapshots,swap,boot}

mount -o subvol=@home,compress=zstd:1,noatime /dev/disk/by-label/nixos /mnt/home
mount -o subvol=@nix,compress=zstd:1,noatime /dev/disk/by-label/nixos /mnt/nix
mount -o subvol=@log,compress=zstd:1,noatime /dev/disk/by-label/nixos /mnt/var/log
mount -o subvol=@snapshots,compress=zstd:1,noatime /dev/disk/by-label/nixos /mnt/.snapshots
mount -o subvol=@swap,noatime /dev/disk/by-label/nixos /mnt/swap

mount /dev/disk/by-label/EFI /mnt/boot
```

## 10. Create Swapfile
```bash
btrfs filesystem mkswapfile --size 8G /mnt/swap/swapfile
swapon /mnt/swap/swapfile
```

## 11. Clone Repo & Install
```bash
nix-env -iA nixos.git
git clone https://github.com/Linuxury/nixos-configs.git /mnt/etc/nixos
cd /mnt/etc/nixos
```

Install the correct host:
```bash
nixos-install --flake .#ThinkPad
```

(Replace ThinkPad as needed.)

Set root password when prompted.

## 12. Reboot
```bash
swapoff -a
umount -R /mnt
reboot
```

## Move project to Documents
Caution: Only do this on the first boot.
```bash
sudo mkdir -p ~/Documents/GitRepos
sudo cp -r /etc/nixos ~/Documents/GitRepos/nixos-configs
ls -ld ~/Documents/GitRepos/nixos-configs
sudo chown -R $USER: ~/Documents/GitRepos/nixos-configs
cd ~/Documents/GitRepos/nixos-configs
git init
git add .
git commit -m "Initial NixOS install"
```

Then:
```bash
sudo rm -rf /etc/nixos
sudo ln -s ~/Documents/GitRepos/nixos-configs /etc/nixos
```

Verify:
```bash
ls -l /etc/nixos
```

Should show a symlink.

## Sync with GitHub after moving the project
From inside the repo:
```bash
git fetch origin
git reset --hard origin/main
```

This will:
 - Discard your 1 local commit
 - Make your working tree identical to GitHub’s main
 - Leave no divergence
 - Avoid any merge or rebase logic

After this:
```bash
git status
```

Should show:
```bash
On branch main
Your branch is up to date with 'origin/main'.
nothing to commit, working tree clean
```
Optional cleanup:
```bash
git pull --prune
```
Then proceed normally

Now you can rebuild without Git noise:
```bash
sudo nixos-rebuild switch --flake ~/Documents/GitRepos/nixos-configs#ThinkPad
```
or for a short you could use the allias
```bash
rebuild
```

## Rollback

At boot:
 - Hold Shift / Esc
 - Select older generation

Or:
```bash
sudo nixos-rebuild switch --rollback
```
