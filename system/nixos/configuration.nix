{pkgs, ...}: {
  users.users.pawel_chabros = {
    extraGroups = [
      "openfortivpn"
    ];
    packages = with pkgs; [
      freerdp3
      keepass
      libreoffice
      openfortivpn
      redisinsight
      rocketchat-desktop
      teams-for-linux
      thunderbird
    ];
  };

  security.sudo.extraRules = [
    {
      groups = ["openfortivpn"];
      commands = [
        "/etc/profiles/per-user/pawel_chabros/bin/openfortivpn"
        "${pkgs.openfortivpn}/bin/openfortivpn"
      ];
    }
  ];

  services = {
    blueman.enable = true;
  };
}
