{pkgs, ...}: let
  git-copy-branch =
    pkgs.writeShellScriptBin "gbc" (builtins.readFile ./git-branch-copy.sh);
  clone-for-worktrees =
    pkgs.writeScriptBin "clone-for-worktrees"
    (builtins.readFile ./clone-for-worktrees.sh);
in {
  users.users.pawel_chabros = {
    packages = [clone-for-worktrees git-copy-branch];
  };
}
