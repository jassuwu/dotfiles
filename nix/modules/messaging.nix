{
  config,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    fractal
    whatsapp-for-linux
  ];
}
