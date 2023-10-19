{ ... }: {
  programs = {
    fzf = {
      enable = true;
      enableZshIntegration = true;
      fileWidgetCommand = "fd --type f";
      fileWidgetOptions = [ "--preview 'head {}'" ];
    };
  };
}
