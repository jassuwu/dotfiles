{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    networkmanager-openvpn
    gnome-shell-extensions
    gnome-control-center
    gnomeExtensions.tiling-assistant
    gnomeExtensions.window-calls
  ];
}
