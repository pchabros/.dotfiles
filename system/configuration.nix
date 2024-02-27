# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, pkgs, ... }:

let
  clone-for-worktrees = pkgs.writeScriptBin "clone-for-worktrees"
    (builtins.readFile
      ../users/pawel_chabros/git/aliases/clone-for-worktrees.sh);
in {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Enable flakes
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    gc = {
      automatic = true;
      randomizedDelaySec = "14m";
      options = "--delete-older-than 10d";
    };
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  networking.wireless = {
    enable = true;
    networks = {
      "WLAN1-105ND1".pskRaw =
        "6fbe04f1ae9259eaed7c81fbcece51aefc3d823a15513efcbb04385eb04a2684";
      "Redmi Note 7".pskRaw =
        "b6505b31c60c5c9d2dda1697f7b978d2d7e245b2dc488ef01631dcff4ae48ef0";
    };
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  # networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Warsaw";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pl_PL.UTF-8";
    LC_IDENTIFICATION = "pl_PL.UTF-8";
    LC_MEASUREMENT = "pl_PL.UTF-8";
    LC_MONETARY = "pl_PL.UTF-8";
    LC_NAME = "pl_PL.UTF-8";
    LC_NUMERIC = "pl_PL.UTF-8";
    LC_PAPER = "pl_PL.UTF-8";
    LC_TELEPHONE = "pl_PL.UTF-8";
    LC_TIME = "pl_PL.UTF-8";
  };

  # Configure console keymap
  console.keyMap = "pl2";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.pawel_chabros = {
    isNormalUser = true;
    initialPassword = "123";
    extraGroups = [ "networkmanager" "wheel" "audio" "openfortivpn" "docker" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      clone-for-worktrees
      discord
      dolphin
      gimp
      grim
      libreoffice
      nodejs
      nodePackages.nodemon
      openfortivpn
      playerctl
      rocketchat-desktop
      slurp
      spotify
      teams-for-linux
      tmux-sessionizer
      tree
      wl-clipboard
    ];
  };

  security = {
    sudo.extraRules = [{
      groups = [ "openfortivpn" ];
      commands = [
        "/etc/profiles/per-user/pawel_chabros/bin/openfortivpn"
        "${pkgs.openfortivpn}/bin/openfortivpn"
      ];
    }];
    rtkit.enable = true;
  };

  services = {
    greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command = "$HOME/.local/bin/starthl";
          user = "pawel_chabros";
        };
        default_session = initial_session;
      };
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
    blueman.enable = true;
    xremap.config.keymap = [{
      name = "Global";
      remap = { "CapsLock" = "Shift-Semicolon"; };
    }];
  };

  sound = {
    enable = true;
    mediaKeys.enable = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment = {
    localBinInPath = true;
    sessionVariables = {
      GDK_BACKEND = "wayland";
      MOZ_ENABLE_WAYLAND = "1";
      WLR_NO_HARDWARE_CURSORS = "1";
      WLR_RENDERER_ALLOW_SOFTWARE = "1";
    };
    systemPackages = with pkgs; [ wget ];
    pathsToLink = [ "/share/zsh" ];
  };

  fonts.packages = with pkgs; [
    corefonts
    (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" ]; })
    recursive
    roboto-mono
    vistafonts
  ];

  programs = {
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    };
    zsh.enable = true;
  };
  xdg.portal.wlr.enable = true;

  systemd.user.services.kanshi = {
    description = "kanshi daemon";
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.kanshi}/bin/kanshi -c kanshi_config_file";
    };
  };

  virtualisation.docker = {
    enable = true;
    daemon.settings = {
      "insecure-registries" = [ "http://192.168.115.184:5000" ];
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
