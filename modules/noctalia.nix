{ inputs, ... }: {
  flake.nixosModules.NahalZenNoctalia = { config, pkgs, lib, ... }:
  with lib;
  let
    cfg = config.noctalia;
  in {
    options.noctalia = {
      enable = mkEnableOption "noctalia window manager";
      autostart = {
        enable = mkOption {
          type = types.bool;
          default = true;
          description = "Whether to autostart noctalia with mango";
        };
      };
    };

    config = mkIf cfg.enable {
      environment.systemPackages = with pkgs; [
        inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];

      systemd.user.services.noctalia-mango = mkIf cfg.autostart.enable {
        description = "Noctalia Mango Autostart";
        wantedBy = [ "graphical-session.target" ];
        partOf = [ "graphical-session.target" ];
        after = [ "graphical-session.target" ];
        serviceConfig = {
          Type = "simple";
          ExecStart = "${inputs.mangowc.packages.${pkgs.stdenv.hostPlatform.system}.default}/bin/mango";
          Restart = "on-failure";
        };
      };
    };
  };
}