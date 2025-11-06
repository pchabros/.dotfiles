{pkgs, ...}: {
  users.users.pawel_chabros = {
    packages = with pkgs; [
      clamav
      keepass
      libreoffice
      teams-for-linux
      thunderbird
      websocat
    ];
  };
  services = {
    blueman.enable = true;
    clamav = {
      daemon.enable = true;
      scanner.enable = true;
      updater.enable = true;
    };
  };
  networking.wg-quick.interfaces = {
    qrk1.configFile = "/home/pawel_chabros/.config/vscode/pchabros1.conf";
    # qrk2.configFile = "/home/pawel_chabros/.config/vscode/pchabros2.conf";
  };
}
