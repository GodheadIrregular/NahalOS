{ inputs, ... }: {
  flake.nixosModules.NahalZenPackages = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      # ── System / CLI ─────────────────────────────────────────
      neovim                        # Terminal editor
      git                           # Version control
      curl                          # HTTP client
      wget                          # File downloader
      yazi                          # Terminal file manager
      ttyper                        # Typing speed test
      caligula                       # ISO/USB flasher
      bluetui                       # Bluetooth TUI client

      # ── Desktop / GUI ────────────────────────────────────────
      inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
      vscode                        # IDE / code editor
      rofi                          # Application launcher
      ghostty                       # GPU-accelerated terminal
      nautilus                      # File manager (GNOME Files)
      loupe                         # Image viewer
      gapless                       # Music player (formerly g4music)
      clapper                       # Video player

      # ── Productivity ─────────────────────────────────────────
      libreoffice                   # Office suite
      zotero
      obsidian
      foliate                       # E-book reader
      papers                        # Document viewer

      file-roller                   # Archive manager (GNOME)

      # ── Graphics / Design ────────────────────────────────────
      blender                       # 3D modeling / rendering
      gimp                          # Image editor
      inkscape                      # Vector graphics editor
      krita                         # Digital painting

      # ── Audio / Video ────────────────────────────────────────
      zrythm                        # Digital audio workstation
      shortwave                     # Internet radio player
      kdePackages.kdenlive          # Video editor

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

    # ── XDG Desktop Portals & MIME defaults ─────────────────
    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-gnome
      ];
    };

    xdg.mime.defaultApplications = {
      # Text / Code
      "text/plain" = "nvim.desktop";
      "text/html" = "zen-browser.desktop";
      "application/json" = "nvim.desktop";

      # Images
      "image/png" = "org.gnome.Loupe.desktop";
      "image/jpeg" = "org.gnome.Loupe.desktop";
      "image/gif" = "org.gnome.Loupe.desktop";
      "image/webp" = "org.gnome.Loupe.desktop";
      "image/bmp" = "org.gnome.Loupe.desktop";
      "image/x-xcf" = "gimp.desktop";
      "image/x-psd" = "gimp.desktop";
      "image/x-raw" = "gimp.desktop";

      # SVG — use Inkscape for editing
      "image/svg+xml" = "org.inkscape.Inkscape.desktop";

      # Audio
      "audio/mpeg" = "io.gitlab.gapless.desktop";
      "audio/ogg" = "io.gitlab.gapless.desktop";
      "audio/flac" = "io.gitlab.gapless.desktop";
      "audio/wav" = "io.gitlab.gapless.desktop";
      "audio/x-m4a" = "io.gitlab.gapless.desktop";
      "audio/x-wavpack" = "io.gitlab.gapless.desktop";

      # Video
      "video/mp4" = "io.github.rafostar.Clapper.desktop";
      "video/mpeg" = "io.github.rafostar.Clapper.desktop";
      "video/webm" = "io.github.rafostar.Clapper.desktop";
      "video/x-matroska" = "io.github.rafostar.Clapper.desktop";
      "video/quicktime" = "io.github.rafostar.Clapper.desktop";
      "video/x-msvideo" = "io.github.rafostar.Clapper.desktop";

      # Documents
      "application/pdf" = "org.gnome.Papers.desktop";
      "application/epub+zip" = "com.github.johnfactotum.Foliate.desktop";
      "application/vnd.oasis.opendocument.text" = "libreoffice-writer.desktop";
      "application/vnd.oasis.opendocument.spreadsheet" = "libreoffice-calc.desktop";
      "application/vnd.oasis.opendocument.presentation" = "libreoffice-impress.desktop";
      "application/msword" = "libreoffice-writer.desktop";
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = "libreoffice-writer.desktop";
      "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = "libreoffice-calc.desktop";
      "application/vnd.openxmlformats-officedocument.presentationml.presentation" = "libreoffice-impress.desktop";
      "application/vnd.ms-powerpoint" = "libreoffice-impress.desktop";
      "application/vnd.ms-excel" = "libreoffice-calc.desktop";
      "application/x-fictionbook+xml" = "com.github.johnfactotum.Foliate.desktop";
      "application/x-mobipocket-ebook" = "com.github.johnfactotum.Foliate.desktop";
      "application/x-cbr" = "com.github.johnfactotum.Foliate.desktop";
      "application/x-cbz" = "com.github.johnfactotum.Foliate.desktop";

      # Internet / Feeds
      "x-scheme-handler/http" = "zen-browser.desktop";
      "x-scheme-handler/https" = "zen-browser.desktop";
      "x-scheme-handler/mailto" = "thunderbird.desktop";
      "message/rfc822" = "thunderbird.desktop";
      "application/x-extension-htm" = "zen-browser.desktop";
      "application/x-extension-html" = "zen-browser.desktop";
      "application/x-extension-shtml" = "zen-browser.desktop";
      "application/xhtml+xml" = "zen-browser.desktop";
      "text/xml" = "zen-browser.desktop";
      "application/rss+xml" = "shortwave.desktop";

      # Archives — File Roller
      "application/zip" = "org.gnome.FileRoller.desktop";
      "application/x-tar" = "org.gnome.FileRoller.desktop";
      "application/gzip" = "org.gnome.FileRoller.desktop";
      "application/x-bzip2" = "org.gnome.FileRoller.desktop";
      "application/x-xz" = "org.gnome.FileRoller.desktop";
      "application/x-zstd" = "org.gnome.FileRoller.desktop";
      "application/x-7z-compressed" = "org.gnome.FileRoller.desktop";
      "application/x-rar" = "org.gnome.FileRoller.desktop";
      "application/x-cd-image" = "org.gnome.FileRoller.desktop";
      "application/x-iso9660-image" = "org.gnome.FileRoller.desktop";
      "application/x-compress" = "org.gnome.FileRoller.desktop";
      "application/x-lzip" = "org.gnome.FileRoller.desktop";
      "application/x-lz4" = "org.gnome.FileRoller.desktop";
      "application/x-lzop" = "org.gnome.FileRoller.desktop";
      "application/x-brotli" = "org.gnome.FileRoller.desktop";
      "application/vnd.rar" = "org.gnome.FileRoller.desktop";
      "application/x-archive" = "org.gnome.FileRoller.desktop";

      # Directories / Filesystem
      "inode/directory" = "org.gnome.Nautilus.desktop";

      # 3D models
      "model/gltf+json" = "blender.desktop";
      "model/gltf-binary" = "blender.desktop";
      "model/obj" = "blender.desktop";
      "model/stl" = "blender.desktop";
      "model/3mf" = "blender.desktop";
      "application/x-blender" = "blender.desktop";
      "image/x-exr" = "blender.desktop";

      # Vector graphics
      "application/x-illustrator" = "org.inkscape.Inkscape.desktop";
      "application/postscript" = "org.inkscape.Inkscape.desktop";

      # Krita
      "application/x-krita" = "org.kde.krita.desktop";

      # Kdenlive
      "application/x-kdenlive" = "org.kde.kdenlive.desktop";

      # Zrythm project files
      "application/x-zrythm" = "org.zrythm.Zrythm.desktop";
    };

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