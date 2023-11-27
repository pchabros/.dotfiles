{ config, pkgs, inputs, ... }: {
  imports = [
    ./alacritty
    ./email
    ./firefox
    ./fuzzel
    ./fzf
    ./git
    ./gtk
    ./hyprland
    ./lazygit
    ./neovim
    ./starship
    ./tmux
    ./wallpaper
    ./wpaperd
    ./zsh
    inputs.nix-colors.homeManagerModules.default
  ];
  colorScheme = inputs.nix-colors.colorSchemes.nord;
  home = {
    username = "pawel_chabros";
    homeDirectory = "/home/pawel_chabros";
    stateVersion = "unstable";
  };
  programs = {
    home-manager.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
