{ config, pkgs, ... }: {
  programs = {
    git = {
      enable = true;
      userName = "pchabros";
      userEmail = "pawel.chabros@yahoo.pl";
    };
    gh = {
      enable = true;
      extensions = with pkgs; [
        gh-dash
      ];
    };
  };
}
