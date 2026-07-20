{
  programs.firefox = {
    enable = true;
    profiles.default = {
      settings = {
        "media.ffmpeg.vaapi.enabled" = true;
        "gfx.webrender.all" = true;
      };
    };
  };
  home.file.".mozilla/firefox/profiles.ini".force = true;
}
