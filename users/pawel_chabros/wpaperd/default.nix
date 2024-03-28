{ lib, is-laptop, main-monitor, side-monitor, ... }: {
  programs.wpaperd = {
    enable = true;
    settings = {
      ${main-monitor} = {
        path = ./pictures/3440x1440;
        duration = "5m";
      };
      ${side-monitor} = {
        path = ./pictures/1440x2560;
        duration = "5m";
      };
      eDP-1 = lib.mkIf is-laptop {
        path = ./pictures/1920x1200;
        duration = "5m";
      };
    };
  };
}
