{
  config,
  pkgs,
  ...
}: {
  # User Account
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

  # System & Boot
  networking.hostName = "nixos-btw";
  time.timeZone = "Europe/Berlin";

  boot.loader.limine.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Graphics & Nvidia
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
  };

  # Hardware Services
  services.printing.enable = true;

  # Localization
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

  # XDG Portals
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    wlr = {
      enable = true;
      settings = {
        screencast = {
          max_fps = 180;
          chooser_type = "dmenu";
          chooser_cmd = "${pkgs.wofi}/bin/wofi --show dmenu";
        };
      };
    };
    #wlr.settings.screencast = {
    #  chooser_type = "simple";
    #  chooser_cmd = "${pkgs.slurp}/bin/slurp -f %o -or";
    #};
    extraPortals = with pkgs; [
      xdg-desktop-portal-termfilechooser
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];
    config = {
      common = {
        default = ["wlr"];
        "org.freedesktop.impl.portal.ScreenCast" = ["wlr"];
        "org.freedesktop.impl.portal.FileChooser" = ["termfilechooser" "gtk"];
      };
    };
  };

  # Environment
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  # Nix Package Manager Configuration
  nix = {
    settings.experimental-features = ["nix-command" "flakes"];
    extraOptions = ''
      !include ${config.sops.secrets.github-nix.path}
    '';
  };

  system.stateVersion = "25.11";
}
