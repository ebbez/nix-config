{ pkgs, ... }: {
  home.username = "ebbe";
  home.homeDirectory = "/home/ebbe";

  home.packages = with pkgs; [
    kdePackages.konsole
    kdePackages.konqueror
    keepassxc
    brave
    discord
    thunderbird
    vscodium
    libreoffice-qt6-fresh
  ];

  services.syncthing.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraConfig = ''
      set expandtab
      set smartindent
      set tabstop=2
      set shiftwidth=2
    '';
  };

  programs.git = {
    enable = true;
    userName = "Ebbez";
    userEmail = "7920708+ebbez@users.noreply.github.com";
  };

  # Let home-manager manage & update itself
  programs.home-manager.enable = true;

  home.stateVersion = "24.11";
}
