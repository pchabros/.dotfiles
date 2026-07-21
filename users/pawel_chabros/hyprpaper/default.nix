{
  config,
  main-monitor,
  side-monitor,
  ...
}: let
  home = config.home.homeDirectory;
  main = "${home}/.config/wallpapers/3440x1440/sluuht7tf7n51.png";
  side = "${home}/.config/wallpapers/1440x2560/7076046.jpg";
  laptop = "${home}/.config/wallpapers/1920x1200/1920x1080-nord-theme-based-wallpapers-v0-0mwe138ullm81.webp";
in {
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "off";
      splash = false;
      preload = [
        main
        side
        laptop
      ];
      wallpaper = [
        {
          monitor = main-monitor;
          path = main;
          fit_mode = "cover";
        }
        {
          monitor = side-monitor;
          path = side;
          fit_mode = "cover";
        }
        {
          monitor = "eDP-1";
          path = laptop;
          fit_mode = "cover";
        }
      ];
    };
  };
  xdg.configFile.wallpapers = {
    source = ./pictures;
  };
}
