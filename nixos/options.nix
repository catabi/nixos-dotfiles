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

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
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

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  users.users.catab = {
    isNormalUser = true;
    description = "catab";
    extraGroups = ["networkmanager" "wheel" "input" "tty"];
    packages = with pkgs; [];
  };
  services.getty.autologinUser = "catab";

  time.timeZone = "Europe/Berlin";

  # fix fractional scaling
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
  # Enable Flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  system.stateVersion = "25.11"; # No
}
