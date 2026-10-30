{
  programs.lazygit = {
    enable = true;
    settings = {
      git.ignoreWhitespaceInDiffView = true;
      keybinding.universal = {
        prevItem-alt = "l";
        nextItem-alt = "k";
        scrollLeft = "<c-j>";
        prevBlock-alt = "j";
        nextBlock-alt = ";";
        scrollUpMain-alt1 = "<c-l>";
        scrollDownMain-alt1 = "<c-k>";
      };
    };
  };
}
