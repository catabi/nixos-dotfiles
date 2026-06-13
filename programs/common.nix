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

    ## sway
    grim
    slurp
    wl-color-picker
    ## Hyprland stuff
    hyprland-qtutils
    hyprpolkitagent
    hyprshot
    xdg-desktop-portal-hyprland
    hyprtoolkit
    wireplumber
    libgtop
    wl-clipboard
    gvfs
    libchamplain_libsoup3
    dart-sass

    ## terminals
    alacritty
    kitty
    kdePackages.konsole

    ## Browsers
    firefox
    vivaldi
    google-chrome

    ## Media Players/Editors
    qimgv
    gimp
    mpv
    libreoffice
    audacity
    qpwgraph
    kdePackages.kdenlive
    pear-desktop
    godot
    obsidian
    vscodium
    lmms
    reaper
    reaper-sws-extension
    davinci-resolve
    eloquent

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
    yazi
    yaziPlugins.drag
    yaziPlugins.chmod
    yaziPlugins.mount
    yaziPlugins.bypass
    yaziPlugins.compress
    yaziPlugins.bookmarks
    yaziPlugins.wl-clipboard
    yaziPlugins.recycle-bin
    zip
    ueberzugpp
    unrar
    unzip
    meson
    gnumake

    ## Connectivity/Games/etc.
    discord
    steam
    r2modman
    vesktop
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
    xdg-desktop-portal-gtk
    kdePackages.qtsvg
    wineWow64Packages.waylandFull
    nixd
    nixpkgs-fmt
    planify
    cava
    gh
    gnupg
    git-crypt
    fuzzel
    gnome-calculator
    hyprpicker
    libsForQt5.qt5ct
    cinny-desktop
    yt-dlp
    pango
    jp2a
    kdePackages.filelight
    sops
    swayfx
    greenfoot
    gsettings-desktop-schemas
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

  nixpkgs.overlays = [inputs.millennium.overlays.default];
  # steam
  programs.steam = {
    enable = true;
    package = pkgs.millennium-steam;
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

  programs.sway = {
    enable = true;
    package = pkgs.swayfx;
    #wrapperFeatures.gtk = true;
  };

  programs.hyprland = {
    enable = true;
    #withUWSM = true;
    xwayland.enable = true;
    #package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    #portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

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
