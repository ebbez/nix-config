{ pkgs, nix-flatpak, ... }: {
  home.username = "ebbe";
  home.homeDirectory = "/home/ebbe";

  imports = [
    nix-flatpak.homeManagerModules.nix-flatpak
  ];

  home.packages = with pkgs; [
    kdePackages.kcalc
    kdePackages.krecorder

    keepassxc
    brave
    thunderbird
    vscodium
    libreoffice-qt6-fresh
    restic
    radicale
    yt-dlp
    vlc
    unzip

    jetbrains.phpstorm
    php84
    php84Packages.composer
  ];

  services.flatpak = {
    packages = [
      "com.discordapp.Discord"
    ];
  };

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
    extraConfig = {
      "push" = {
        "autoSetupRemote" = "true";
      };
    };
  };

  programs.gpg.enable = true;

  # Radicale Calendar and contact server service for local serving from user account & user Syncthing folder
  systemd.user.services.radicale = {
    Unit = {
      Description = "A simple CalDAV (calendar) and CardDAV (contact) server";
    };

    Service = {
      WorkingDirectory = "/home/ebbe/Documents/Sync/CalDAV en CardDAV";
      ExecStart = "/usr/bin/env radicale --config=radicale.ini";
      Restart = "on-failure";
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  # Let home-manager manage & update itself
  programs.home-manager.enable = true;

  home.stateVersion = "24.11";
}
