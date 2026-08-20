{
  lib,
  pkgs,
  ...
}: {
  imports = [./keymap.nix];

  programs.yazi = {
    enable = true;
    plugins = {
      drag = pkgs.yaziPlugins.drag;
      chmod = pkgs.yaziPlugins.chmod;
      mount = pkgs.yaziPlugins.mount;
      bypass = pkgs.yaziPlugins.bypass;
      compress = pkgs.yaziPlugins.compress;
      bookmarks = pkgs.yaziPlugins.bookmarks;
      wl-clipboard = pkgs.yaziPlugins.wl-clipboard;
      recycle-bin = pkgs.yaziPlugins.recycle-bin;
    };
    settings = {
      yazi = lib.importTOML ./yazi.toml;
      #theme = lib.importTOML ./theme.toml;
    };
  };
}
