{ config, pkgs, ... }: {
  services.syncthing = {
    enable = true;
    user = "ebbe";
    openDefaultPorts = true;
    dataDir = "/home/ebbe/";
    configDir = "/home/ebbe/.config/syncthing";
  };
}
