{pkgs, ...}: {
  enable = false;
  package = pkgs.firefox.override {
    cfg = {
      # Gnome shell native connector
      enableGnomeExtensions = true;
    };
  };
}
