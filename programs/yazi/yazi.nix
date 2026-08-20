{
  lib,
  pkgs,
  ...
}: {
  programs.yazi = {
    enable = true;
    plugins = with pkgs.yaziPlugins; {
      chmod = chmod;
    };

    settings = {
      yazi = lib.importTOML ./yazi.toml;
      #theme = lib.importTOML ./theme.toml;
    };
  };
}
