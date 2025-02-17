{ pkgs, ... }: {
  home.username = "ebbe";
  home.homeDirectory = "/home/ebbe";

  home.packages = with pkgs; [
    neovim
    kitty
    keepassxc
    brave
  ];

  services.syncthing.enable = true;

  programs.git.enable = true;
  programs.git = {
    userName = "Ebbez";
    userEmail = "7920708+ebbez@users.noreply.github.com";
  };

  programs.home-manager.enable = true;

  home.stateVersion = "24.11";
}
