{hostname, ...}: {
  imports = [
    ./shared/configuration.nix
    ./${hostname}/configuration.nix
    ./${hostname}/hardware-configuration.nix
    ./scripts
  ];
}
