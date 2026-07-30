{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./nvf-configuration.nix
  ];

  # System packages
  environment.systemPackages = with pkgs; [
    # System Essentials & Utilities
    btop
    cliphist
    easyeffects
    fastfetch
    file
    git
    git-crypt
    gnupg
    htop
    jq
    libnotify
    localsend
    mission-center
    pwvucontrol
    rofi
    sops
    vim
    wget

    # Desktop Environment & Hyprland
    cava
    dart-sass
    fuzzel
    grim
    hyprland-qtutils
    hyprpicker
    hyprpolkitagent
    hyprshot
    hyprtoolkit
    libchamplain_libsoup3
    libgtop
    planify
    slurp
    wayfreeze
    wireplumber
    wl-clipboard
    wl-color-picker

    # Terminals
    alacritty
    foot
    kdePackages.konsole
    kitty

    # Browsers
    firefox
    google-chrome
    vivaldi

    # Media & Content Creation
    audacity
    davinci-resolve
    eloquent
    gimp
    godot
    kdePackages.kdenlive
    libreoffice
    lmms
    mpv
    obsidian
    pear-desktop
    qimgv
    qpwgraph
    reaper
    reaper-sws-extension
    vscodium
    yt-dlp

    # File Management & Archiving
    appimage-run
    ffmpeg
    gnumake
    kdePackages.dolphin
    kdePackages.filelight
    kdePackages.kio
    kdePackages.kio-admin
    kdePackages.kio-extras
    kdePackages.kio-fuse
    meson
    ueberzugpp
    unrar
    unzip
    yazi
    zip

    # Yazi Plugins
    yaziPlugins.bookmarks
    yaziPlugins.bypass
    yaziPlugins.chmod
    yaziPlugins.compress
    yaziPlugins.drag
    yaziPlugins.mount
    yaziPlugins.recycle-bin
    yaziPlugins.wl-clipboard

    # Gaming & Social
    cinny-desktop
    discord
    olympus
    prismlauncher
    r2modman
    steam
    vesktop
    waywall

    # Development
    gh
    greenfoot
    jdk17
    jdk21
    jdk25
    nixd
    nixpkgs-fmt
    openjdk
    python3

    # Misc Dependencies
    gnome-calculator
    gsettings-desktop-schemas
    jp2a
    kdePackages.qtsvg
    libsForQt5.qt5ct
    melonloader-installer
    pango
    wineWow64Packages.waylandFull
  ];

  # OBS Studio with CUDA & plugins
  programs.obs-studio = {
    enable = true;
    package = pkgs.obs-studio.override {cudaSupport = true;};
    plugins = with pkgs.obs-studio-plugins; [
      obs-vkcapture
      input-overlay
      obs-pipewire-audio-capture
    ];
  };

  # Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  # Window Managers
  programs.mango = {
    enable = true;
    package = inputs.mangowm.packages.${pkgs.stdenv.hostPlatform.system}.default;
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Audio (PipeWire)
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Network & Bluetooth
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # OpenSSH Service & SSH Client Config
  services.openssh = {
    enable = true;
    ports = [22];
    settings = {
      PasswordAuthentication = false;
      AllowUsers = null;
      UseDns = true;
      X11Forwarding = false;
      PermitRootLogin = "no";
    };
  };

  programs.ssh.extraConfig = ''
    Host nixos-btw
      Hostname 192.168.1.123
      Port 22
      User catab
  '';

  # Integration Services
  services.udisks2.enable = true;
  security.polkit.enable = true;
  services.gvfs.enable = true;

  # Printer Drivers
  services.printing.drivers = with pkgs; [
    brlaser
    brgenml1lpr
    brgenml1cupswrapper
  ];

  nixpkgs.config.allowUnfree = true;
}
