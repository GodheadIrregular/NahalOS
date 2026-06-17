{ ... }: {
  flake.nixosModules.NahalZenPackages = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      # ── System / CLI ─────────────────────────────────────────
      neovim                        # Terminal editor
      git                           # Version control
      curl                          # HTTP client
      wget                          # File downloader

      # ── Desktop / GUI ────────────────────────────────────────
      firefox                       # Web browser
      vscode                        # IDE / code editor

      # ── Gaming ───────────────────────────────────────────────
      steam
      steam-run
      gamemode                      # GameMode — automatic game optimisations
      mangohud                      # MangoHud — performance overlay (FPS, temps)
      wineWowPackages.stable        # Wine (stable) for running Windows games
      winetricks                    # Wine configuration helper
      lutris                        # Game manager with Wine/Proton support
      protonup-qt                   # Proton GE installer
    ];

    # ── Gaming services ──────────────────────────────────────
    security.pam.services.steam.enable = true;
    programs.gamemode.enable = true;
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      gamescopeSession.enable = true;
    };
  };
}