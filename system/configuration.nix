{
  inputs,
  pkgs,
  hostname,
  version,
  ...
}:

{
  imports = [
    ./${hostname}/hardware-configuration.nix
    ./scripts
  ];

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    gc = {
      automatic = true;
      randomizedDelaySec = "14m";
      options = "--delete-older-than 4d";
    };
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = hostname;
    wireless =
      if hostname == "nixos" then
        {
          enable = true;
          networks = {
            "WLAN1-105ND1".pskRaw = "6fbe04f1ae9259eaed7c81fbcece51aefc3d823a15513efcbb04385eb04a2684";
            "Redmi Note 7".pskRaw = "b6505b31c60c5c9d2dda1697f7b978d2d7e245b2dc488ef01631dcff4ae48ef0";
          };
        }
      else
        { };
  };

  time.timeZone = "Europe/Warsaw";

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

  console.keyMap = "pl2";

  users.users.pawel_chabros = {
    isNormalUser = true;
    initialPassword = "123";
    extraGroups = [
      "networkmanager"
      "wheel"
      "audio"
      "openfortivpn"
      "docker"
    ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      discord
      dolphin
      fd
      gimp
      grim
      keepass
      libreoffice
      nodePackages.nodemon
      nodejs
      openfortivpn
      playerctl
      radianWrapper
      ripgrep
      rocketchat-desktop
      slurp
      spotify
      teams-for-linux
      tldr
      tree
      whatsapp-for-linux
      wl-clipboard
      xdg-utils
    ];
  };

  security = {
    sudo.extraRules = [
      {
        groups = [ "openfortivpn" ];
        commands = [
          "/etc/profiles/per-user/pawel_chabros/bin/openfortivpn"
          "${pkgs.openfortivpn}/bin/openfortivpn"
        ];
      }
    ];
    rtkit.enable = true;
  };

  services = {
    blueman.enable = true;
    # dbus.enable = true;
    greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command = "$HOME/.dotfiles/users/pawel_chabros/hyprland/config/starthl";
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
    xremap = {
      withWlroots = true;
      watch = true;
      config = {
        modmap = [
          {
            remap = {
              "CapsLock" = {
                alone = [
                  "Shift_L"
                  "Semicolon"
                ];
                held = "Alt_L";
              };
              "Enter" = {
                alone = "Enter";
                held = "Ctrl_L";
              };
              "Tab" = {
                alone = "Tab";
                held = "Super_L";
              };
            };
          }
        ];
      };
    };
    udev.extraRules = ''
      # CMSIS-DAP for microbit
      SUBSYSTEM=="usb", ATTR{idVendor}=="0d28", ATTR{idProduct}=="0204", MODE:="666"
    '';
  };

  nixpkgs.config.allowUnfree = true;

  environment = {
    localBinInPath = true;
    sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
    };
    systemPackages = with pkgs; [
      devenv
      wget
    ];
    pathsToLink = [ "/share/zsh" ];
  };

  fonts.packages = with pkgs; [
    corefonts
    (nerdfonts.override {
      fonts = [
        "FiraCode"
        "JetBrainsMono"
      ];
    })
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

  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
    };
  };

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

  system.stateVersion = version;
}
