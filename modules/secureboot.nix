{ pkgs, lib, ... }: {
  boot.loader.systemd-boot.enable = lib.mkForce false;

  imports = [
    lanzaboote.nixosModules.lanzaboote
  ]

  environment.systemPackages = with pkgs; [
    sbctl
  ];

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };
}
