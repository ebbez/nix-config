{ pkgs, ... }: {
  programs.git.enable = true;
  programs.git = {
    userName = "Ebbez";
    userEmail = "7920708+ebbez@users.noreply.github.com";
  };
}
