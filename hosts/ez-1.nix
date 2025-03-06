# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, modulesPath, ... }:

{
  networking.hostName = "ez-1"; # Define your hostname.

  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  boot.initrd.luks.devices."luks-2fba2ac9-7a5b-4724-b19e-ed7777586230".device = "/dev/disk/by-uuid/2fba2ac9-7a5b-4724-b19e-ed7777586230";

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/9d878e9d-0577-4f24-88c9-00e2ce26780f";
      fsType = "btrfs";
      options = [ "subvol=@" ];
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/9d878e9d-0577-4f24-88c9-00e2ce26780f";
      fsType = "btrfs";
      options = [ "subvol=@home" ];
    };

  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/9d878e9d-0577-4f24-88c9-00e2ce26780f";
      fsType = "btrfs";
      options = [ "subvol=@nix" ];
    };

  fileSystems."/var/log" =
    { device = "/dev/disk/by-uuid/9d878e9d-0577-4f24-88c9-00e2ce26780f";
      fsType = "btrfs";
      options = [ "subvol=@log" ];
    };

  fileSystems."/var/tmp" =
    { device = "/dev/disk/by-uuid/9d878e9d-0577-4f24-88c9-00e2ce26780f";
      fsType = "btrfs";
      options = [ "subvol=@tmp" ];
    };

  fileSystems."/swap" =
    { device = "/dev/disk/by-uuid/9d878e9d-0577-4f24-88c9-00e2ce26780f";
      fsType = "btrfs";
      options = [ "subvol=@swap" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/14DC-9CA4";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  swapDevices = [ { device = "/swap/swapfile"; } ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp5s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  system.stateVersion = "24.11"; # Don't touch this (This option is for comparing changes in defaults of apps at the release of this NixOS version).
}
