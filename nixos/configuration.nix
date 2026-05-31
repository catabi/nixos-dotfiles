{config, ...}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    ../programs/common.nix
    ./fonts.nix
    ./options.nix
    ./libraries.nix
    ../config/sops.nix
  ];
}
