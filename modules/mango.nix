{ inputs, ... }: {
  flake.nixosModules.NahalZenMango = { config, pkgs, lib, ... }:
  with lib;
  let
    cfg = config.mango;
  in {
    options.mango = {
      enable = mkEnableOption "mangowc window manager";
      configFile = mkOption {
        type = types.path;
        default = ../configs/mango/config.json;
        description = "Path to mango configuration file";
      };
    };

    config = mkIf cfg.enable {
      environment.systemPackages = with pkgs; [
        inputs.mangowc.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];

      environment.etc."mango/config.json".source = cfg.configFile;
    };
  };
}