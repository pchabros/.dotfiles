{ pkgs, ... }: {
  programs = {
    git = {
      enable = true;
      delta.enable = true;
      extraConfig = {
        "includeIf \"gitdir:~/.dotfiles/\"" = {
          path = "${./config/config-personal}";
        };
        "includeIf \"gitdir:~/\"" = { path = "${./config/config-anx}"; };
      };
    };
    gh = {
      enable = true;
      extensions = with pkgs; [ gh-dash ];
    };
  };
}
