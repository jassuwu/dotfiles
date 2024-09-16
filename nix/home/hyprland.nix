{...}: {
  enable = true;
  settings = {
    "$mod" = "SUPER";
    exec-once = ["ags"];
    exec = [
      ''gsettings set org.gnome.desktop.interface gtk-theme "Adwaita"   # for GTK3 apps''
      ''gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"   # for GTK4 apps''
      ''gsettings set org.gnome.desktop.interface cursor-theme "Banana-Catppuccin-Mocha"''
      ''gsettings set org.gnome.desktop.interface cursor-size 96''
    ];
    xwayland = {
      force_zero_scaling = true;
    };
    general = {
      gaps_out = 16;
    };
    input = {
      follow_mouse = 1;
      touchpad = {
        natural_scroll = true;
        disable_while_typing = true;
        tap-to-click = false;
        middle_button_emulation = false;
      };
      sensitivity = 0;
    };
    env = [
      "QT_QPA_PLATFORMTHEME,qt6ct"
      "HYPRCURSOR_SIZE,96"
      "XCURSOR_SIZE,96"
    ];
    monitor = [
      ", preferred, auto, 1"
    ];
    bezier = [
      "easeOutBack,0.34,1.56,0.64,1"
      "easeInBack,0.36,0,0.66,-0.56"
      "easeInCubic,0.32,0,0.67,0"
      "easeInOutCubic,0.65,0,0.35,1"
    ];
    animation = [
      "windowsIn,1,5,easeOutBack,popin"
      "windowsOut,1,5,easeInBack,popin"
      "fadeIn,0"
      "fadeOut,1,10,easeInCubic"
      "workspaces,1,4,easeInOutCubic,slide"
    ];
    bind =
      [
        "$mod, Return, exec, alacritty"
        "$mod, Q, killactive"
        "$mod, W, exec, zen-browser"
        "$mod, E, exec, nautilus"
        "$mod, V, togglefloating"
        "$mod, R, exec, wofi --show drun"
        "$mod, P, pseudo"
        "$mod, J, togglesplit"
        "$mod, T, togglegroup"
        "$mod+ALT, J, changegroupactive, f"
        "$mod+ALT, K, changegroupactive, f"
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
        "$mod, h, movefocus, l"
        "$mod, l, movefocus, r"
        "$mod, k, movefocus, u"
        "$mod, j, movefocus, d"
      ]
      ++ (
        builtins.concatLists (builtins.genList (
            x: let
              ws = let
                c = (x + 1) / 10;
              in
                builtins.toString (x + 1 - (c * 10));
            in [
              "$mod, ${ws}, workspace, ${toString (x + 1)}"
              "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
            ]
          )
          10)
      );
  };
  extraConfig = ''
  '';
}
