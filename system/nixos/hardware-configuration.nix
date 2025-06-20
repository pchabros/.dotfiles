{
  config,
  lib,
  modulesPath,
  ...
}: {
  imports = [(modulesPath + "/installer/scan/not-detected.nix")];
  boot = {
    initrd.availableKernelModules = [
      "xhci_pci"
      "thunderbolt"
      "nvme"
      "usbhid"
      "usb_storage"
      "sd_mod"
    ];
    initrd.kernelModules = [];
    kernelModules = ["kvm-intel"];
    extraModulePackages = [];
  };
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/b42ebc3b-505d-46a6-9990-2d4e455c7ec6";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/7CD3-E9E2";
      fsType = "vfat";
    };
    "/share" = {
      device = "/dev/disk/by-uuid/3253-5810";
      fsType = "vfat";
    };
  };

  swapDevices = [];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware = {
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    bluetooth = {
      enable = true;
      powerOnBoot = false;
    };
    graphics.enable = true;
  };
}
