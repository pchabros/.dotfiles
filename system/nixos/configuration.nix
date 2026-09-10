{
  pkgs,
  config,
  system,
  username,
  agenix,
  ...
}: {
  users.users.pawel_chabros.packages = with pkgs; [
    age
    claude-code
    firefox
    microsoft-edge
    slack
    teams-for-linux
  ];

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };

  programs.globalprotect-openconnect.enable = true;

  services = {
    openvpn.servers.work = {
      config = "config /etc/openvpn/Pawel.Chabros.ovpn";
      updateResolvConf = true;
    };
    kolide-launcher.enable = true;
    blueman.enable = true;
  };

  age = {
    identityPaths = ["/home/${username}/.ssh/id_ed25519"];
    secrets.kolide = {
      file = ../../secrets/kolide.age;
      mode = "0600";
    };
  };

  environment = {
    systemPackages = [agenix.packages.${system}.default];
    etc."kolide-k2/secret" = {
      mode = "0600";
      source = config.age.secrets.kolide.path;
    };
  };
}
