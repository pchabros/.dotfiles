{
  programs = {
    fzf = {
      enable = true;
      enableZshIntegration = true;
      defaultCommand = "rg --files --hidden --glob '!.git'";
      fileWidgetCommand = "fd --type f --hidden";
      fileWidgetOptions = ["--preview 'head {}'"];
      changeDirWidgetOptions = ["--preview 'tree -C {} | head -200'"];
    };
  };
}
