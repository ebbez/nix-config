{ pkgs, ... }: {
  home.username = "ebbe";
  home.homeDirectory = "/home/ebbe";

  imports = [
    ./applications/git.nix
#    ./applications/web.nix
#    ./applications/personal-admin.nix
#    ./applications/sync.nix
  ];

  home.packages = with pkgs; [
    neovim
    kitty
    keepassxc
    brave
  ];

  services.syncthing.enable = true;

  # Let home-manager manage & update itself
  programs.home-manager.enable = true;

  home.stateVersion = "24.11";
}
