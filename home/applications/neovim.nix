{ pkgs, ... }: {
  programs.neovim.enable = true;

  programs.neovim = {
    defaultEditor = true;
    extraConfig = ''
      set expandtab
      set smartindent
      set tabstop=2
      set shiftwidth=2
    '';
  };
}
