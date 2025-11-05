# Personal NixOS config

This repository contains all the files needed to setup NixOS on my 
personal machines.

## Project folder structure

```
nix-config/
├── flake.lock
├── flake.nix       # entry-point for Nix flakes
├── home.nix        # userspace stuff (home-manager)
├── hosts
│   ├── ez-1.nix    # specific to my main desktop computer
│   └── ez-2.nix    # specific to my laptop
├── modules
│   ├── gaming.nix      # Steam
│   ├── pc-common.nix   # The "OS-configuration" common to all my PCs, 
│   │                   # DEs, virtualization, etc.
│   ├── secureboot.nix  # Secure Boot module, Lanzaboote bootloader (systemd-based)
│   │                   # will replace the default bootloader.
│   └── tpm-unlock.nix  # Module that enables TPM2 at boot to auto-unlock disk encryption.
└── README.md
```

## Install (notes for myself) DISCLAIMER: This might be incomplete or incorrect.

Use a terminal/minimal installation method.

### 1. Create partitions

Use `fdisk` or follow commands below

```
# # 0:0:0 means 'default', so next partition number:first available sector:last available sector.
# sgdisk --zap-all <DISK> # Format partition table to GPT format 
# sgdisk --new 0:0:+1G --typecode 0:ef00 <DISK> # 1GB EFI partition
# sgdisk --new 0:0:0 <DISK> # Assigns rest disk space to the root/LUKS container partition
```

### 2. Format partitions

```
# mkfs.fat -F32 /dev/nvme0n1p1
# cryptsetup luksFormat /dev/nvme0n1p2
# <ENTER PASSWORD> REMEMBER!
# cryptsetup open /dev/nvme0n1p2 root
# mkfs.btrfs /dev/mapper/root
```

### 3. Mount partitions, create subvolumes & mount subvolumes

```
# mount /dev/mapper/root /mnt
# cd /mnt
# btrfs subvolume create /mnt/@
# btrfs sub create /mnt/@home
# btrfs sub create /mnt/@nix
# btrfs sub create /mnt/@tmp
# btrfs sub create /mnt/@log
# btrfs sub create /mnt/swap
# umount /mnt
# mount -o noatime,nodiratime,compress=zstd,x-mount.mkdir,subvol=@ /dev/mapper/root /mnt/
# mount -o noatime,nodiratime,compress=zstd,x-mount.mkdir,subvol=@home /dev/mapper/root /mnt/home
# mount -o noatime,nodiratime,compress=zstd,x-mount.mkdir,subvol=@nix /dev/mapper/root /mnt/nix
# mount -o noatime,nodiratime,compress=zstd,x-mount.mkdir,subvol=@tmp /dev/mapper/root /mnt/var/tmp
# mount -o noatime,nodiratime,compress=zstd,x-mount.mkdir,subvol=@log /dev/mapper/root /mnt/var/log
# mount -o noatime,nodiratime,compress=zstd,x-mount.mkdir,subvol=@swap /dev/mapper/root /mnt/swap
# mkdir /mnt/boot
# mount /dev/nvme0np1 /mnt/boot
```

### 4. Download  this flake, comment out modules that can't be used yet

```
# git clone https://github.com/ebbez/nix-config
# cd nix-config
```

Edit `flake.nix` and comment out the `secureboot.nix` and `tpm-unlock.nix` modules in the machine
config you are installing NixOS to.

### 5. Create & enable swap

```
# btrfs filesystem mkswapfile -s 20G /swap/swapfile
# swapon /swap/swapfile
```

### 6. Create and replace hardware configuration

```
# nixos-generate-config --root /mnt
# cp -i /mnt/etc/nixos/hardware-configuration.nix ./hosts/ez-X.nix
```

Add `networking.hostname = "ez-X";` to the beginning of the ez-X.nix file.


### 7. Install

```
# nixos-install --flake .#ez-X # replace ez-X with the identifier of the machine you are installing NixOS to
# nixos-enter --root /mnt -c 'passwd ebbe'
```

You possibly might need to copy the nix-config repo to the mounted root partition. `cp . /mnt/etc/nixos` or `cp . /mnt/home/ebbe/` and then symlink it using `ln -s /home/ebbe/nix-config /etc/nixos`

### 8. Restart and enable Secure Boot and TPM unlock

After restarting, create keys for Secure Boot, enable Lanzaboote (`modules/secureboot.nix`) and TPM unlocking (`modules/tpm-unlock.nix`)

```
$ sudo sbctl status # Check whether Secure Boot is in Setup Mode
$ sudo sbctl create-keys
$ sudo sbctl enroll-keys -m -f # enroll own with Microsoft's keys and OEM keys (Framework)
$ vim nix-config/flake.nix # uncomment Secure Boot & tpm-unlock
$ systemd-cryptenroll --tpm2-device=auto /dev/nvme0n1p2 # enroll TPM key to LUKS container
```
