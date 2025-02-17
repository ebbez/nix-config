{ pkgs, lib, ... }: {
  boot.loader.systemd-boot.enable = lib.mkForce false;

  environment.systemPackages = with pkgs; [
    sbctl
  ];

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };
}
