{ config, pkgs, ... }:
{
  hardware.graphics = {
    enable = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      # This is specific to my MSI GF63 Thin Laptop
      nvidiaBusId = "PCI:1:0:0";
      intelBusId = "PCI:0:2:0";
    };

    modesetting.enable = true;

    powerManagement = {
      enable = true;
      finegrained = true;
    };

    open = false;
    nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}
