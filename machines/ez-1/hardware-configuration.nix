# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  networking.hostName = "ez-1"; # Define your hostname.

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/13ac1cd2-d038-48aa-bf25-a8bff38e9522";
      fsType = "btrfs";
      options = [ "subvol=@" "noatime" "nodiratime" ];
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/13ac1cd2-d038-48aa-bf25-a8bff38e9522";
      fsType = "btrfs";
      options = [ "subvol=@home" "noatime" "nodiratime" ];
    };

  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/13ac1cd2-d038-48aa-bf25-a8bff38e9522";
      fsType = "btrfs";
      options = [ "subvol=@nix" "noatime" "nodiratime" ];
    };

  fileSystems."/var/lib" =
    { device = "/dev/disk/by-uuid/13ac1cd2-d038-48aa-bf25-a8bff38e9522";
      fsType = "btrfs";
      options = [ "subvol=@lib" "noatime" "nodiratime" ];
    };

  fileSystems."/var/log" =
    { device = "/dev/disk/by-uuid/13ac1cd2-d038-48aa-bf25-a8bff38e9522";
      fsType = "btrfs";
      options = [ "subvol=@log" "noatime" "nodiratime" ];
    };

  fileSystems."/.snapshots" =
    { device = "/dev/disk/by-uuid/13ac1cd2-d038-48aa-bf25-a8bff38e9522";
      fsType = "btrfs";
      options = [ "subvol=@snapshots" "noatime" "nodiratime" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/3789-2071";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp5s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}