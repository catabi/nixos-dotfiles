{
  lib,
  pkgs,
  ...
}: {
  programs.yazi = {
    enable = true;
    plugins = {
      inherit (pkgs.yaziPlugins) chmod mount bypass compress bookmarks wl-clipboard recycle-bin;
    };
    settings = {
      yazi = lib.importTOML ./yazi.toml;
      #theme = lib.importTOML ./theme.toml;
    };
  };
}
