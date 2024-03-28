{ pkgs, main-monitor, side-monitor, ... }:
let
  config = {
    ${main-monitor} = [ "1" "5" ];
    ${side-monitor} = [ "2" "3" "4" ];
  };
  bindMonitor = monitor: workspaces:
    builtins.concatStringsSep "\n"
    (map (workspace: "workspace=${workspace}, monitor:${monitor}") workspaces);
  bindMonitorsConfig = builtins.concatStringsSep "\n"
    (pkgs.lib.attrsets.attrValues (builtins.mapAttrs bindMonitor config));
in {
  xdg.configFile = {
    "hypr/hyprland.conf".text = ''
      ${builtins.readFile ./config/hyprland.conf}
      ${bindMonitorsConfig}
    '';
  };
}
