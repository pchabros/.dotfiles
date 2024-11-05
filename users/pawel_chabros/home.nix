{ inputs, ... }:
{
  imports = [
    # ./wpaperd
    ./alacritty
    ./avizo
    ./bat
    ./btop
    ./chromium
    ./direnv
    ./email
    ./eza
    ./firefox
    ./fuzzel
    ./fzf
    ./git
    ./gtk
    ./hyprland
    ./hyprpaper
    ./kanshi
    ./lazygit
    ./lf
    ./neovim
    ./nushell
    ./qutebrowser
    ./starship
    ./tmux
    ./wlogout
    ./zathura
    ./zoxide
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
