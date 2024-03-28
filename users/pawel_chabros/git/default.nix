{ pkgs, is-laptop, ... }: {
  programs = {
    git = {
      enable = true;
      delta.enable = true;
      aliases = { cwt = "!clone-for-worktrees"; };
      extraConfig = if is-laptop then {
        "includeIf \"gitdir:~/.dotfiles/\"" = {
          path = "${./config/config-personal}";
        };
        "includeIf \"gitdir:~/\"" = { path = "${./config/config-anx}"; };
      } else {
        "includeIf \"gitdir:~/\"" = { path = "${./config/config-personal}"; };
      };
    };
    gh = {
      enable = true;
      extensions = with pkgs; [ gh-dash ];
    };
  };
}
