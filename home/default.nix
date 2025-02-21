{ pkgs, ... }: {
  home.username = "ebbe";
  home.homeDirectory = "/home/ebbe";

  imports = [
    ./applications/git.nix
    ./applications/neovim.nix
  ];

  home.packages = with pkgs; [
    kdePackages.konsole
    keepassxc
    brave
    discord
    thunderbird
    vscodium
    libreoffice-qt6-fresh
  ];

  services.syncthing.enable = true;

  # Let home-manager manage & update itself
  programs.home-manager.enable = true;

  home.stateVersion = "24.11";
}
