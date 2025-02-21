{ pkgs, lib, lanzaboote, ... }: {
  boot.loader.systemd-boot.enable = lib.mkForce false;

  imports = [
    lanzaboote.nixosModules.lanzaboote
  ];

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };
}
