{ pkgs, ... }:
let
  systemDependencies = with pkgs; [
    # unarchiver
    android-tools
    catdoc
    ffmpegthumbnailer
    glow
    imagemagick
    miller
    pandoc
    pipx
    poppler
    sqlite
    tree
    woff2
    xlsx2csv
  ];
  pythonDependencies = with pkgs.python312Packages; [
    docx2txt
    nbconvert
  ];
  perlDependencies = with pkgs.perl540Packages; [ ImageExifTool ];
in
{
  home.packages = systemDependencies ++ pythonDependencies ++ perlDependencies;
  programs.yazi.enable = true;
  xdg.configFile = {
    "yazi/yazi.toml".source = ./config/yazi.toml;
    "yazi/keymap.toml".source = ./config/keymap.toml;
    "yazi/theme.toml".source = ./config/theme.toml;
    "yazi/plugins/preview.yazi".source = pkgs.fetchFromGitHub {
      owner = "Urie96";
      repo = "preview.yazi";
      rev = "25d749c4016db34c88c14e7caed867956d9315b1";
      sha256 = "sha256-dF+a+BX8cjff/muzRwgbcCPUcoIQGNn3vcZD554RgIA=";
    };
  };
}
