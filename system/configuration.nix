{
  pkgs,
  hostname,
  username,
  version,
  devenv-latest,
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
      trusted-users = root ${username}
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
      "audio"
      "docker"
      "lp"
      "networkmanager"
      "openfortivpn"
      "scanner"
      "wheel"
    ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      discord
      dolphin
      fd
      firefox-devedition
      freerdp3
      gimp
      grim
      hyprcursor
      hyprpaper
      insomnia
      keepass
      libreoffice
      nodejs
      nodePackages.nodemon
      openfortivpn
      playerctl
      ripgrep
      rocketchat-desktop
      simplex-chat-desktop
      slurp
      spotify
      teams-for-linux
      tldr
      tree
      ueberzugpp
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

  hardware = {
    sane = {
      enable = true;
      extraBackends = [ pkgs.hplipWithPlugin ];
    };
    printers = {
      ensurePrinters = [
        {
          name = "hp-envy_4500_series";
          location = "Home";
          deviceUri = "usb://HP/ENVY%204500%20series?serial=CN4AG121B905X4&interface=1";
          model = "HP/hp-envy_4500_series.ppd.gz";
          ppdOptions = {
            PageSize = "A4";
          };
        }
      ];
      ensureDefaultPrinter = "hp-envy_4500_series";
    };
  };

  services = {
    blueman.enable = true;
    printing = {
      enable = true;
      drivers = [ pkgs.hplip ];
    };
    dbus.enable = true;
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
      jack.enable = true;
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

  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
    };
    mime = {
      enable = true;
      defaultApplications = {
        "default-web-browser" = [ "firefox-devedition.desktop" ];
        "text/html" = [ "firefox-devedition.desktop" ];
        "x-scheme-handler/http" = [ "firefox-devedition.desktop" ];
        "x-scheme-handler/https" = [ "firefox-devedition.desktop" ];
        "x-scheme-handler/about" = [ "firefox-devedition.desktop" ];
        "x-scheme-handler/unknown" = [ "firefox-devedition.desktop" ];
      };
    };
  };

  nixpkgs.config.allowUnfree = true;

  environment = {
    localBinInPath = true;
    sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
    };
    systemPackages = (with pkgs; [ wget ]) ++ [ devenv-latest ];
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
      xwayland.enable = true;
    };
    zsh.enable = true;
    xonsh.enable = true;
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
      "insecure-registries" = [ "docker.registry.anx:5000" ];
    };
  };

  system.stateVersion = version;
}
