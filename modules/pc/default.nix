# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  # Bootloader.
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  imports = [
    ./locale.nix
    ./plasma.nix
    ./audio.nix
    ./user.nix
    ./syncthing.nix
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    kdePackages.isoimagewriter
    kdePackages.filelight
    git
    steam
    sbctl
  ];

  # Enable flake
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
