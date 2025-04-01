# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "nl_NL.UTF-8";
    LC_IDENTIFICATION = "nl_NL.UTF-8";
    LC_MEASUREMENT = "nl_NL.UTF-8";
    LC_MONETARY = "nl_NL.UTF-8";
    LC_NAME = "nl_NL.UTF-8";
    LC_NUMERIC = "nl_NL.UTF-8";
    LC_PAPER = "nl_NL.UTF-8";
    LC_TELEPHONE = "nl_NL.UTF-8";
    LC_TIME = "nl_NL.UTF-8";
  };

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;
  hardware.i2c.enable = true; # for KDE monitor brightness control widget

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    #jack.enable = true;

    # use the example session manager
    #media-session.enable = true;
  };
  security.rtkit.enable = true;
  services.pulseaudio.enable = false;

  # Flatpak with declarative config in ./home.nix (uses nix-flatpak)
  services.flatpak.enable = true;

  # Docker
  virtualisation.docker = {
    enable = true;
    storageDriver = "btrfs";
  };

  # QEMU/KVM
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ebbe = {
    isNormalUser = true;
    description = "Ebbe";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };

  environment.systemPackages = with pkgs; [
    kdePackages.partitionmanager
    sbctl
    neovim
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
}
