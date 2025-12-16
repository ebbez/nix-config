{ pkgs, nix-flatpak, ... }: {
  home.username = "ebbe";
  home.homeDirectory = "/home/ebbe";
  programs.bash = {
    enable = true;
    shellAliases = {
      vim = "nvim";
    };
  };

  imports = [
    nix-flatpak.homeManagerModules.nix-flatpak
  ];

  home.packages = with pkgs; [
    kdePackages.kcalc
    kdePackages.krecorder
    kdePackages.isoimagewriter
    kdePackages.filelight
    kdePackages.kamoso
    kdePackages.kleopatra

    keepassxc
    brave
    thunderbird
    libreoffice-qt6-fresh
    vlc
    qbittorrent
    nextcloud-client
    element-desktop

    restic
    backrest
    #radicale
    yt-dlp
    unzip

    gcc

    vscodium
    android-studio

    jetbrains.phpstorm

    jetbrains.pycharm-professional
    (python3.withPackages (subpkgs: with subpkgs; [ tkinter matplotlib ]))

    rustc
    cargo

    go

    ocrmypdf
  ];

  services.flatpak = {
    packages = [
      "com.discordapp.Discord"
      "com.spotify.Client"
      "com.rustdesk.RustDesk"
    ];
  };

  services.syncthing.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    # extraConfig = ''
    #   set expandtab
    #   set smartindent
    #   set tabstop=2
    #   set shiftwidth=2
    # '';
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Ebbez";
        email = "7920708+ebbez@users.noreply.github.com";
      };
      "push" = {
        "autoSetupRemote" = "true";
      };
    };    
  };

  programs.gpg.enable = true;

  # Radicale Calendar and contact server service for local serving from user account & user Syncthing folder
  # systemd.user.services.radicale = {
  #   Unit = {
  #     Description = "A simple CalDAV (calendar) and CardDAV (contact) server";
  #   };

  #   Service = {
  #     WorkingDirectory = "/home/ebbe/Documents/Sync/CalDAV en CardDAV";
  #     ExecStart = "/usr/bin/env radicale --config=radicale.ini";
  #     Restart = "on-failure";
  #   };

  #   Install = {
  #     WantedBy = [ "default.target" ];
  #   };
  # };

  # Let home-manager manage & update itself
  programs.home-manager.enable = true;

  home.stateVersion = "24.11";
}
