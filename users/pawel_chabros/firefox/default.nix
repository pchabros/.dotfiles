{ inputs, username, ... }: {
  programs.firefox = {
    enable = true;
    profiles.${username} = {
      extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
        angular-devtools
        darkreader
      ];
    };
  };
}
