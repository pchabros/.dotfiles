{
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "x-scheme-handler/http" = "chromium.desktop";
      "x-scheme-handler/https" = "chromium.desktop";
      "text/html" = "chromium.desktop";
      "x-scheme-handler/about" = "chromium.desktop";
      "x-scheme-handler/unknown" = "chromium.desktop";
    };
  };

  programs.chromium = {
    enable = true;
    extensions = [
      {id = "ienfalfjdbdpebioblfackkekamfmbnh";}
      {id = "lmhkpmbekcpmknklioeibfkpmmfibljd";}
      {id = "dhlnjfhjjbminbjbegeiijdakdkamjoi";}
    ];
    commandLineArgs = [
      "--enable-features=VaapiVideoDecoder,VaapiVideoEncoder"
      "--ozone-platform=wayland"
    ];
  };
}
