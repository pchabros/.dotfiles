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
      availableKernelModules = ["nvme" "xhci_pci" "thunderbolt" "usbhid" "usb_storage" "sd_mod"];
      kernelModules = [];
      luks.devices."luks-15c6e401-640c-4e8d-b0c1-0cf13ddff7d9".device = "/dev/disk/by-uuid/15c6e401-640c-4e8d-b0c1-0cf13ddff7d9";
    };
    kernelModules = ["kvm-amd"];
    extraModulePackages = [];
  };
  fileSystems."/" = {
    device = "/dev/mapper/luks-15c6e401-640c-4e8d-b0c1-0cf13ddff7d9";
    fsType = "ext4";
  };
  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/F3DC-8D26";
    fsType = "vfat";
    options = ["fmask=0077" "dmask=0077"];
  };
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware = {
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    bluetooth.enable = true;
  };
}
