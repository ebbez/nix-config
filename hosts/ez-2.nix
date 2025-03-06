# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, modulesPath, ... }:

{
  networking.hostName = "ez-2"; # Define your hostname.

  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "usb_storage" "sd_mod" "sdhci_pci" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/c2530f27-c885-48b4-9acf-2bb642cad936";
      fsType = "btrfs";
      options = [ "subvol=@" ];
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/c2530f27-c885-48b4-9acf-2bb642cad936";
      fsType = "btrfs";
      options = [ "subvol=@home" ];
    };

  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/c2530f27-c885-48b4-9acf-2bb642cad936";
      fsType = "btrfs";
      options = [ "subvol=@nix" ];
    };

  fileSystems."/var/log" =
    { device = "/dev/disk/by-uuid/c2530f27-c885-48b4-9acf-2bb642cad936";
      fsType = "btrfs";
      options = [ "subvol=@log" ];
    };

  fileSystems."/var/tmp" =
    { device = "/dev/disk/by-uuid/c2530f27-c885-48b4-9acf-2bb642cad936";
      fsType = "btrfs";
      options = [ "subvol=@tmp" ];
    };

  fileSystems."/swap" =
    { device = "/dev/disk/by-uuid/c2530f27-c885-48b4-9acf-2bb642cad936";
      fsType = "btrfs";
      options = [ "subvol=@swap" ];
    };

  boot.initrd.luks.devices."luks-4b05f731-adb8-4bc7-9fc4-7a1db93bd3f3".device = "/dev/disk/by-uuid/4b05f731-adb8-4bc7-9fc4-7a1db93bd3f3";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/83D2-09B1";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  swapDevices = [ { device = "/swap/swapfile"; } ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp2s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  system.stateVersion = "24.11"; # Don't touch this (This option is for comparing changes in defaults of apps at the release of this NixOS version).
}
