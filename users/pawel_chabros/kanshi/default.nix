{
  lib,
  is-laptop,
  main-monitor,
  side-monitor,
  ...
}:
{
  services.kanshi = {
    enable = true;
    systemdTarget = "";
    settings = [
      {
        profile.name = "monitors";
        profile.outputs = [
          {
            criteria = main-monitor;
            status = "enable";
            mode = "3440x1440@50";
            position = "0,0";
          }
          {
            criteria = side-monitor;
            status = "enable";
            mode = "2560x1440@60";
            position = "3440,0";
            transform = "270";
          }
          (lib.mkIf is-laptop {
            criteria = "eDP-1";
            status = "disable";
          })
        ];
      }
      # TODO: check how it works on PC
      # lib.mkIf
      # is-laptop
      {
        profile.name = "laptop";
        profile.outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
          }
        ];
      }
    ];
  };
}
