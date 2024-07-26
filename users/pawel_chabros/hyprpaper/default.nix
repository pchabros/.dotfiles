{ main-monitor, side-monitor, ... }:
let
  main = toString ./pictures/3440x1440/sluuht7tf7n51.png;
  side = toString ./pictures/1440x2560/7076046.jpg;
  laptop = toString ./pictures/1920x1200/1920x1080-nord-theme-based-wallpapers-v0-0mwe138ullm81.webp;
in
{
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
        "${main-monitor},${main}"
        "${side-monitor},${side}"
        "eDP-1,${laptop}"
      ];
    };
  };
}
