#
#  Nord Theme - Home Manager
#
# Included from ~/.setup/hosts/vortex/home.nix

{ pkgs, ... }:

{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    ## GTK
    nordic
    zafiro-icons
    bibata-cursors

    ## Breeze
    libsForQt5.breeze-qt5
    libsForQt5.breeze-gtk
    libsForQt5.breeze-icons

    ## Fonts
    nerdfonts
  ];

  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    gtk.enable = true;
    size = 22;
  };

  home.file.".icons/Bibata-Modern-Classic/".source = "${pkgs.bibata-cursors}/share/icons/Bibata-Modern-Classic";
  home.file.".icons/Zafiro-icons-Dark/".source = "${pkgs.zafiro-icons}/share/icons/Zafiro-icons-Dark";

  # Symlink wallpapers to `.config/wallpapers`
  home.file."wallpapers" = {
    source = ./wallpapers;
    target = ".config/wallpapers";
    recursive = true;
  };

  gtk = {
    enable = true;
    font.name = "FiraCode Nerd Font";
    theme = {
      name = "Nordic-darker";
      package = pkgs.nordic;
    };
    iconTheme = {
      name = "Zafiro-icons-Dark";
      package = pkgs.zafiro-icons;
    };
    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
    };
    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };
}
