{ pkgs, lib, ... }: {
  programs.steam = {
    enable = true;
    localNetworkGameTransfers.openFirewall = true;
  };
}
