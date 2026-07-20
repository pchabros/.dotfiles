{pkgs, ...}: {
  users.users.pawel_chabros = {
    packages = with pkgs; [
      electrum
    ];
  };
  services. udev.extraRules = ''
    # CMSIS-DAP for microbit
    SUBSYSTEM=="usb", ATTR{idVendor}=="0d28", ATTR{idProduct}=="0204", MODE="0666"

    # ST-Link/V2.1 for STM32F4
    SUBSYSTEM=="usb", ATTR{idVendor}=="0483", ATTR{idProduct}=="374b", MODE="0666", TAG+="uaccess"
  '';
}
