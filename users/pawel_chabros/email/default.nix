{ pkgs, config, current, ... }:

{
  programs.thunderbird = {
    enable = true;
    profiles.pawel_chabros = {
      isDefault = true;
    };
  };

  accounts.email = {
    accounts.outlook = {
      realName = "pawel_chabros";
      address = "pawel.chabros@analyx.com";
      userName = "pawel_chabros";
      primary = true;
      imap = {
        host = "https://mail.analyx.com/owa/";
        port = 80;
        tls = {
          certificatesFile = /share/pawel_chabros_email.cer;
          useStartTls = true;
        };
      };
      thunderbird = {
        enable = true;
        profiles = [ "pawel_chabros" ];
      };
    };
  };
}
