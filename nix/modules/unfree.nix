{
  pkgs,
  lib,
  ...
}: {
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) (
      map lib.getName [
        pkgs.vesktop
        pkgs.unstable.keymapp
        pkgs.steam
        pkgs.steam-run
        pkgs.steam-original
      ]
    );

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vesktop
    unstable.keymapp
  ];
}
