{
  config,
  pkgs,
  ...
}: let
  inherit (config.lib.file) mkOutOfStoreSymlink;
in {
  imports = [
    ./ags/default.nix
  ];

  programs.home-manager.enable = true;

  home.username = "jass";
  home.homeDirectory = "/home/jass";
  home.pointerCursor = {
    x11.enable = true;
    gtk.enable = true;
    package = pkgs.banana-cursor-dreams;
    size = 64;
    name = "Banana-Catppuccin-Mocha";
  };

  xdg.enable = true;

  xdg.configFile.nvim.source = mkOutOfStoreSymlink "/home/jass/dotfiles/.config/nvim";

  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };

  home.stateVersion = "24.11";

  programs = {
    tmux = import ./tmux.nix {inherit pkgs;};
    zsh = import ./zsh.nix {inherit config pkgs;};
    neovim = import ./neovim.nix {inherit config pkgs;};
    git = import ./git.nix {inherit config pkgs;};
    zoxide = import ./zoxide.nix {inherit pkgs;};
    fzf = import ./fzf.nix {inherit pkgs;};
    oh-my-posh = import ./oh-my-posh.nix {inherit pkgs;};
  };

  programs.atuin.enable = true;

  gtk = {
    enable = true;
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };

  wayland.windowManager = {
    hyprland = import ./hyprland.nix {inherit pkgs;};
  };
}
