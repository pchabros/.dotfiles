{ inputs, ... }: {
  imports = [
    ./alacritty
    ./avizo
    ./bat
    ./btop
    ./chromium
    ./default_apps
    ./direnv
    ./email
    ./firefox
    ./fuzzel
    ./fzf
    ./git
    ./gtk
    ./hyprland
    ./kanshi
    ./lazygit
    ./lf
    ./neovim
    ./qutebrowser
    ./starship
    ./tmux
    ./wlogout
    ./wpaperd
    ./zathura
    ./zsh
    inputs.nix-colors.homeManagerModules.default
  ];
  colorScheme = inputs.nix-colors.colorSchemes.nord;
  home = {
    username = "pawel_chabros";
    homeDirectory = "/home/pawel_chabros";
    stateVersion = "23.11";
  };
  programs = {
    home-manager.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
