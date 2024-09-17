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
  home.stateVersion = "24.11";
  home.pointerCursor = {
    x11.enable = true;
    gtk.enable = true;
    package = pkgs.banana-cursor-dreams;
    size = 64;
    name = "Banana-Catppuccin-Mocha";
  };

  xdg = {
    enable = true;
    configFile.nvim.source = mkOutOfStoreSymlink "/home/jass/dotfiles/.config/nvim";
  };

  gtk = {
    enable = true;
    theme = {
      name = "rose-pine";
      package = pkgs.rose-pine-gtk-theme;
    };
    iconTheme = {
      name = "rose-pine";
      package = pkgs.rose-pine-icon-theme;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk3";
    style.name = "adwaita-gtk";
  };

  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface".color-scheme = "prefer-light";
  };

  programs = {
    atuin.enable = true;
    tmux = import ./tmux.nix {inherit pkgs;};
    zsh = import ./zsh.nix {inherit config pkgs;};
    neovim = import ./neovim.nix {inherit config pkgs;};
    git = import ./git.nix {inherit config pkgs;};
    zoxide = import ./zoxide.nix {inherit pkgs;};
    fzf = import ./fzf.nix {inherit pkgs;};
    oh-my-posh = import ./oh-my-posh.nix {inherit pkgs;};
  };

  wayland.windowManager = {
    hyprland = import ./hyprland.nix {inherit pkgs;};
  };
}
