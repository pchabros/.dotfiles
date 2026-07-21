{config, ...}: {
  programs.firefox = {
    enable = true;
    profiles.default = {
      settings = {
        "media.ffmpeg.vaapi.enabled" = true;
        "gfx.webrender.all" = true;
      };
    };
    configPath = "${config.xdg.configHome}/mozilla/firefox";
  };
}
