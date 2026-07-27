{
  config,
  lib,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];
  boot = {
    initrd = {
      availableKernelModules = ["nvme" "ehci_pci" "xhci_pci_renesas" "xhci_pci" "usbhid" "usb_storage" "sd_mod" "rtsx_pci_sdmmc"];
      kernelModules = [];
      luks.devices."luks-9a41d631-7264-4893-8adc-125dc05efcdc".device = "/dev/disk/by-uuid/9a41d631-7264-4893-8adc-125dc05efcdc";
    };
    kernelModules = ["kvm-amd"];
    extraModulePackages = [];
  };
  fileSystems."/" = {
    device = "/dev/mapper/luks-9a41d631-7264-4893-8adc-125dc05efcdc";
    fsType = "ext4";
  };
  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/50D2-C206";
    fsType = "vfat";
    options = ["fmask=0077" "dmask=0077"];
  };
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
