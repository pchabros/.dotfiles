{ config, pkgs, ... }: {
  services.random-background = {
    enable = true;
    imageDirectory = "./images";
  };
}
