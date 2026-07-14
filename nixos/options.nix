{
  config,
  pkgs,
  ...
}: {
  # NVIDIA
  hardware.graphics = {
    enable = true;
  };

  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;

    open = true;

    nvidiaSettings = true;
  };

  services.printing.enable = true;

  # Bootloader.
  boot.loader.limine.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos-btw"; # Define your hostname.

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-termfilechooser
      pkgs.xdg-desktop-portal-wlr
      pkgs.xdg-desktop-portal-gtk
    ];
    config = {
      common = {
        default = ["wlr"];
        "org.freedesktop.impl.portal.ScreenCast" = ["wlr"];
        "org.freedesktop.impl.portal.FileChooser" = ["termfilechooser"];
      };
    };
    #wlr.settings.screencast = {
    #  chooser_type = "simple";
    #  chooser_cmd = "${pkgs.slurp}/bin/slurp -f %o -or";
    #};
  };
  nix.extraOptions = ''
    !include ${config.sops.secrets.github-nix.path}
  '';

  users.users.catab = {
    isNormalUser = true;
    description = "catab";
    extraGroups = ["networkmanager" "wheel" "input" "tty"];
    #packages = with pkgs; [];

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKQ8T5wZaJwpRrg77NrkqQh8PO0BbH2vX/SLr4Lih96y leriex123@gmail.com"
    ];
  };
  services.getty.autologinUser = "catab";
  services.getty.autologinOnce = true;
  time.timeZone = "Europe/Berlin";

  #  environment.loginShellInit = ''
  #  [ "$(tty)" = /dev/tty1 ] && exec mango
  #'';

  #''
  #[[ "$(tty)" == /dev/tty1 ]] && sway --unsupported-gpu
  #'';

  # fix fractional scaling
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  # Enable Flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  system.stateVersion = "25.11"; # No
}
