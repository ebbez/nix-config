# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ 
      ../../modules/pc-common.nix
      ../../modules/locale.nix

      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  networking.hostName = "ez-2"; # Define your hostname.

  system.stateVersion = "24.11"; # Don't touch this (This option is for comparing changes in defaults of apps at the release of this NixOS version).
}
