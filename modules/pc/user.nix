{ config, pkgs, ... }: {

  users.users.ebbe = {
    isNormalUser = true;
    description = "Ebbe";
    extraGroups = [ "networkmanager" "wheel" ];
  };

}
