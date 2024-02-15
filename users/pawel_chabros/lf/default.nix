{ pkgs, ... }: {
  programs.lf = {
    enable = true;
    settings = {
      drawbox = true;
      hidden = true;
      icons = true;
      preview = true;
      sixel = true;
    };
    keybindings = {
      j = "updir";
      k = "down";
      l = "up";
      ";" = "open";
    };
    extraConfig = let
      previewer = pkgs.writeShellScriptBin "pv.sh" ''
        case "$(${pkgs.file}/bin/file -Lb --mime-type -- "$1")" in
            image/*)
                ${pkgs.chafa}/bin/chafa -f sixel -s "$2x$3" --animate off --polite on "$1"
                exit 1
                ;;
            *)
                bat "$1"
                ;;
        esac
      '';
    in ''
      set previewer ${previewer}/bin/pv.sh
    '';
  };
  xdg.configFile."lf/icons".source = ./config/icons;
}
