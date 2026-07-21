{self, pkgs, ... }: {

  flake.nixosModules.NahalPlasma = { pkgs, lib, ... }: {
  
    # Enable KDE Plasma 6 desktop.
    services.desktopManager.plasma6.enable = true;
    
    # Disable unwanted KDE packages.
    services.desktopManager.plasma6.excludePackages = with pkgs; [
      kdePackages.konqueror  # Web browser (we use zen-browser)
      kdePackages.akonadiconsole
      kdePackages.akregator
      kdePackages.kaddressbook
      kdePackages.kalarm
      kdePackages.akonadi  # PIM framework
      kdePackages.kmail
      kdePackages.korganizer
      kdePackages.kdepim-runtime
    ];

    # ── KDE Plasma Packages ─────────────────────────────────────────
    environment.systemPackages = with pkgs; [
      
      # Core KDE Applications
      kdePackages.dolphin               # File manager
      kdePackages.kate                  # Text editor
      kdePackages.konsole               # Terminal emulator
      kdePackages.kwrite                # Simple text editor
      kdePackages.gwenview              # Image viewer
      kdePackages.spectacle             # Screenshot tool
      kdePackages.okular                # PDF viewer
      kdePackages.kcalc                 # Calculator
      kdePackages.filelight             # Disk usage analyzer
      kdePackages.partitionmanager        # Partition manager
      kdePackages.ksystemlog            # System log viewer
      kdePackages.discover              # Software center
      kdePackages.kfind               # File search
      kdePackages.khelpcenter           # Help center
      kdePackages.knotes                # Notes application
      
      # System utilities
      kdePackages.kscreen               # Display management
      kdePackages.kscreenlocker         # Screen locker
      kdePackages.kwallet               # KDE wallet
      kdePackages.kio                   # KDE Input/Output framework
      kdePackages.kio-admin             # Admin KIO worker
      kdePackages.kio-fuse              # FUSE KIO integration
      
      # Multimedia
      kdePackages.elisa                 # Music player
      
      # Utilities
      kdePackages.ark                   # Archive manager
      kdePackages.baloo-widgets         # File indexing
      kdePackages.kcharselect           # Character selector
      kdePackages.kcolorchooser         # Color chooser
      kdePackages.kdialog               # Dialog utility
      kdePackages.krdc                  # Remote desktop client
      kdePackages.krfb                  # Desktop sharing server
      kdePackages.ksudoku               # Sudoku game
      kdePackages.ktimer                # Timer
      
      # Plasma components
      kdePackages.plasma-desktop
      kdePackages.plasma-workspace
      kdePackages.plasma-browser-integration
      
      # Appearance
      whitesur-gtk-theme              # WhiteSur GTK Theme (for GTK apps in Plasma)
      bibata-cursors                  # Bibata Cursor Theme
      whitesur-icon-theme             # WhiteSur Icon Theme
      
      # Additional useful apps
      ghostty                         # GPU-accelerated terminal
      mission-center                  # System monitoring
    ];

    # ── XDG Desktop Portals ─────────────────────────────────────────
    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-kde
      ];
    };

    # ── MIME defaults for KDE apps ──────────────────────────────────
    xdg.mime.defaultApplications = {
      # Text / Code
      "text/plain" = "org.kde.kate.desktop";
      "text/html" = "zen-browser.desktop";
      "application/json" = "org.kde.kate.desktop";

      # Images
      "image/png" = "gwenview.desktop";
      "image/jpeg" = "gwenview.desktop";
      "image/gif" = "gwenview.desktop";
      "image/webp" = "gwenview.desktop";
      "image/bmp" = "gwenview.desktop";
      "image/x-xcf" = "gimp.desktop";
      "image/x-psd" = "gimp.desktop";
      "image/x-raw" = "gimp.desktop";

      # SVG
      "image/svg+xml" = "org.inkscape.Inkscape.desktop";

      # Audio
      "audio/mpeg" = "elisa.desktop";
      "audio/ogg" = "elisa.desktop";
      "audio/flac" = "elisa.desktop";
      "audio/wav" = "elisa.desktop";
      "audio/x-m4a" = "elisa.desktop";
      "audio/x-wavpack" = "elisa.desktop";

      # Video
      "video/mp4" = "org.kde.kdenlive.desktop";
      "video/mpeg" = "org.kde.kdenlive.desktop";
      "video/webm" = "org.kde.kdenlive.desktop";
      "video/x-matroska" = "org.kde.kdenlive.desktop";
      "video/quicktime" = "org.kde.kdenlive.desktop";
      "video/x-msvideo" = "org.kde.kdenlive.desktop";

      # Documents
      "application/pdf" = "org.kde.okular.desktop";
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

      # Internet
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

      # Archives
      "application/zip" = "ark.desktop";
      "application/x-tar" = "ark.desktop";
      "application/gzip" = "ark.desktop";
      "application/x-bzip2" = "ark.desktop";
      "application/x-xz" = "ark.desktop";
      "application/x-zstd" = "ark.desktop";
      "application/x-7z-compressed" = "ark.desktop";
      "application/x-rar" = "ark.desktop";
      "application/x-cd-image" = "ark.desktop";
      "application/x-iso9660-image" = "ark.desktop";
      "application/x-compress" = "ark.desktop";
      "application/x-lzip" = "ark.desktop";
      "application/x-lz4" = "ark.desktop";
      "application/x-lzop" = "ark.desktop";
      "application/x-brotli" = "ark.desktop";
      "application/vnd.rar" = "ark.desktop";
      "application/x-archive" = "ark.desktop";

      # Directories
      "inode/directory" = "org.kde.dolphin.desktop";

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

      # Zrythm
      "application/x-zrythm" = "org.zrythm.Zrythm.desktop";
    };

  };
}