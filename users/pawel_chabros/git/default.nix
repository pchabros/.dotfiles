{
  pkgs,
  username,
  is-laptop,
  ...
}: let
  conf = {
    personal = "/home/${username}/.dotfiles/users/${username}/git/config/config-personal";
    solid = "/home/${username}/.dotfiles/users/${username}/git/config/config-solid";
  };
in {
  programs = {
    delta.enable = true;
    git = {
      enable = true;
      settings =
        {
          alias = {cwt = "!clone-for-worktrees";};
          rerere.enabled = true;
        }
        // (
          if is-laptop
          then {
            "includeIf \"gitdir:~/.dotfiles/\"" = {
              path = conf.personal;
            };
            "includeIf \"gitdir:~/wd/\"" = {
              path = conf.personal;
            };
            "includeIf \"gitdir:~/wd/solid-bio/\"" = {
              path = conf.solid;
            };
          }
          else {
            "includeIf \"gitdir:~/\"" = {path = conf.personal;};
          }
        );
    };
    gh = {
      enable = true;
      extensions = with pkgs; [gh-dash];
    };
  };
}
