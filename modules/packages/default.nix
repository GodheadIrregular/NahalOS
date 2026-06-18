{ ... }: {
  flake.nixosModules.NahalZenPackages = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      # ── System / CLI ─────────────────────────────────────────
      neovim                        # Terminal editor
      git                           # Version control
      curl                          # HTTP client
      wget                          # File downloader

      # ── Desktop / GUI ────────────────────────────────────────
      inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
      vscode                        # IDE / code editor

      # ── Productivity ─────────────────────────────────────────
      libreoffice                   # Office suite
      zotero
      obsidian
    
      # ── Communications ────────────────────────────────────────
      vesktop
      whatsie
      thunderbird

      # ── Gaming ───────────────────────────────────────────────
      steam
      steam-run
      gamemode                      # GameMode — automatic game optimisations
      mangohud                      # MangoHud — performance overlay (FPS, temps)
      wineWow64Packages.waylandFull        # Wine (stable) for running Windows games
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