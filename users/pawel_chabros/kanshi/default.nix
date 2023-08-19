{ config, pkgs, ... }: {
  services.kanshi = {
    enable = true;
    systemdTarget = "";
    profiles = {
      laptop = {
        outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
          }
        ];
      };
      with_monitor = {
        outputs = [
          {
            criteria = "HDMI-A-1";
            status = "enable";
            position = "0,0";
          }
          {
            criteria = "eDP-1";
            status = "enable";
            position = "3440,650";
          }
        ];
      };
    };
  };
}
