{
  services.mako = {
    enable = true;
    settings = {
      width = 360;
      height = 120;
      margin = "12";
      padding = "12,16";

      font = "monospace 11";

      background-color = "#1E1E1EE6";
      text-color = "#EFEFEFFF";
      border-size = 0;
      border-radius = 8;
      progress-color = "over #4C7899CC";

      default-timeout = 5000;
      on-button-right = "exec makoctl menu -n \"$id\" -- fuzzel --dmenu -p \"Action: \"";
    };
  };
}
