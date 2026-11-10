{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./nvf-configuration.nix
    #./yazi/yazi.nix
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    ## linux essentials
    vim
    wget
    htop
    linuxHeaders
    git

    ## Other essential stuff
    rofi
    pwvucontrol
    pulseaudio
    cliphist
    easyeffects
    fastfetch
    mission-center
    btop
    localsend

    libnotify
    wl-color-picker
    #xdg-desktop-portal-wlr
    wireplumber
    libgtop
    wl-clipboard
    gvfs
    dart-sass

    ## terminals
    alacritty
    kitty
    foot
    tmux

    ## Browsers
    firefox
    vivaldi

    ## Media Players/Editors
    qimgv
    gimp
    mpv
    libreoffice
    audacity
    qpwgraph
    kdePackages.kdenlive
    godot
    obsidian
    vscodium
    amberol
    #picard # for music automatic metadata
    aseprite
    eloquent

    ## Screenshots and recording

    ## File Stuff
    kdePackages.dolphin
    kdePackages.kio-admin
    kdePackages.kio
    kdePackages.kio-fuse
    kdePackages.kio-extras
    polkit
    file
    appimage-run
    ffmpeg
    zip
    unrar
    unzip
    meson
    gnumake
    #easytag # manual music tags

    ## Yazi
    yazi
    /*
    yaziPlugins.drag
    yaziPlugins.chmod
    yaziPlugins.mount
    yaziPlugins.bypass
    yaziPlugins.compress
    yaziPlugins.bookmarks
    yaziPlugins.wl-clipboard
    yaziPlugins.recycle-bin
    */
    ## Connectivity/Games/etc.
    discord
    vesktop
    steam
    r2modman
    #### Minecraft
    prismlauncher
    waywall
    #### Celeste
    olympus

    ## Programming/Java/Python Stuff
    jdk17
    jdk21
    jdk25
    openjdk
    python3
    jq

    ## Misc
    kdePackages.qtsvg
    wineWow64Packages.waylandFull
    nixd
    nixpkgs-fmt
    planify
    cava
    gh
    gnupg
    gnome-calculator
    libsForQt5.qt5ct
    #cinny-desktop
    yt-dlp
    #jp2a # image to ascii
    #kdePackages.filelight
    sops
    gsettings-desktop-schemas
    melonloader-installer
    #dijo #todo list tui
    vimPlugins.vimtex
    texlivePackages.latexmk
    texliveFull
    miktex
    texlivePackages.pdftex
    texlivePackages.lastpage
  ];
  ## Obs with Nvidia and plugins
  programs.obs-studio = {
    enable = true;
    package = pkgs.obs-studio.override {cudaSupport = true;};
    plugins = with pkgs; [
      obs-studio-plugins.obs-vkcapture
      obs-studio-plugins.input-overlay
      obs-studio-plugins.obs-pipewire-audio-capture
    ];
  };

  # steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    #extraCompatPackages = [pkgs.proton-ge-bin];
  };

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Sound
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  programs.mango = {
    enable = true;
    package = inputs.mangowm.packages.${pkgs.stdenv.hostPlatform.system}.default;
  };

  programs.sway = {
    enable = false;
    package = pkgs.swayfx;
    #wrapperFeatures.gtk = true;
  };

  programs.hyprland = {
    enable = false;
    #xwayland.enable = true;
    #package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    #portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  programs.dconf.enable = true;

  services.openssh = {
    enable = true;
    ports = [22];
    settings = {
      PasswordAuthentication = false;
      AllowUsers = null; # Allows all users by default. Can be [ "user1" "user2" ]
      UseDns = true;
      X11Forwarding = false;
      PermitRootLogin = "no"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
    };
  };

  services.terraria = {
    enable = true;
    port = 25565;
    maxPlayers = 8;
    openFirewall = true;
    #worldPath = "~/.local/share/Terraria/Worlds/YOLO-Defecation.wld";
    autoCreatedWorldSize = "large";
  };

  systemd.services.terraria = {
    serviceConfig = {
      User = "terraria";
      StateDirectory = "terraria";
      CPUAffinity = "0-11";
    };
  };

  programs.ssh = {
    extraConfig = "
      Host nixos-btw
        Hostname 192.168.1.123
        Port 22
        User catab
    ";
  };

  # for dolphin
  services.udisks2.enable = true;
  security.polkit.enable = true;
  services.gvfs.enable = true;

  services.printing.drivers = [
    pkgs.brlaser
    pkgs.brgenml1lpr
    pkgs.brgenml1cupswrapper
  ];

  nixpkgs.config.allowUnfree = true;
}
