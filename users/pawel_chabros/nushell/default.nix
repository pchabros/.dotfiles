{
  programs = {
    nushell = {
      enable = true;
      configFile.source = ./config/config.nu;
    };
    carapace.enable = true;
  };
}
