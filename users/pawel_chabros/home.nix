{ inputs, ... }: {
  imports = [
    ./alacritty
    ./avizo
    ./bat
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
    ./starship
    ./tmux
    ./wlogout
    ./wpaperd
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
