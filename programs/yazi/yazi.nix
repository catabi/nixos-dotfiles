{
  lib,
  pkgs,
  ...
}: {
  programs.yazi = {
    enable = true;
    plugins = {
      chmod.enable = true;
    };

    settings = {
      yazi = lib.importTOML ./yazi.toml;
      #theme = lib.importTOML ./theme.toml;
    };
  };
}
