{self, pkgs, ... }: {

 flake.nixosModules.NahalGnome = { pkgs, lib, ... }: {
 
    # Enable GNOME DE.
   services.displayManager.gdm.enable = true;
   services.desktopManager.gnome.enable = true;
   
   services.gnome.core-apps.enable = false;
   services.gnome.core-developer-tools.enable = false;
   services.gnome.games.enable = false;


     # ── Gnome Packages ─────────────────────────────────────────
     environment.systemPackages = with pkgs; [
       
       # Applications
       gnome-calculator              # Calculator
       gnome-calendar                # Calendar app
       gnome-contacts                # Contacts manager
       gnome-maps                    # Maps application
       gnome-weather                 # Weather app
       gnome-clocks                  # Clocks and timers
       gnome-characters              # Character map
       gnome-font-viewer             # Font viewer
       refine                        # Gnome tweaking utility
       mission-center                # System monitoring and task manager 
       ghostty                       # GPU-accelerated terminal
       nautilus                      # File manager (GNOME Files)
       loupe                         # Image viewer
       amberol                       # Music player
       clapper                       # Video player
       file-roller                   # Archive manager (GNOME)
       gparted                       # Partition editor
       baobab                        # Disk usage analyzer
       gnome-logs                    # System log viewer
       snapshot                      # Camera application
       gnome-extension-manager       # GNOME Extensions management utility
       impression                    # Disk Burning Utility
       errands                       # To-do list manager
       gnome-mahjongg                # Mahjongg solitaire game
       emblem                        # Icon editor
       sherlock-launcher             # Application launcher with search functionality
       hydrapaper

       # ── Gnome Shell Extensions ─────────────────────────────────────────
       gnomeExtensions.user-themes   # Allows using custom themes in Gnome Shell
       gnomeExtensions.tiling-shell  # Adds tiling window management features to Gnome Shell
       gnomeExtensions.appindicator  # Adds support for AppIndicator system tray icons in Gnome Shell
       gnomeExtensions.blur-my-shell # Adds a blur effect to the Gnome Shell top bar and other UI elements

      # ── Appearance ─────────────────────────────────────────
      whitesur-gtk-theme         # WhiteSur GTK Theme — a macOS Big Sur-inspired theme for GTK applications, providing a clean and modern look for Linux desktops
      bibata-cursors             # Bibata Cursor Theme — a modern, stylish cursor theme with various color options and a sleek design
      whitesur-icon-theme        # WhiteSur Icon Theme — a macOS Big Sur-inspired icon theme for Linux, providing a clean and modern look for applications and system icons


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

  };
 }