{
  services.kanshi = {
    enable = true;
    systemdTarget = "";
    profiles = {
      laptop = {
        outputs = [{
          criteria = "eDP-1";
          status = "enable";
        }];
      };
      with_monitor = {
        outputs = [
          {
            criteria = "HDMI-A-1";
            status = "enable";
            mode = "3440x1440@50";
            position = "0,0";
          }
          {
            criteria = "DP-1";
            status = "enable";
            mode = "2560x1440@60";
            position = "3440,0";
            transform = "270";
          }
          {
            criteria = "eDP-1";
            status = "disable";
          }
        ];
      };
    };
  };
}
