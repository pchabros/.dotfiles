{
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
