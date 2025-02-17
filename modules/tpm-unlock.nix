{ pkgs, lib, ... }: {
  boot.initrd.systemd.enable = true;
  boot.initrd.systemd.tpm2.enable = true;
}
