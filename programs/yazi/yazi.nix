{
  lib,
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = [
    (inputs.yazi.packages.${pkgs.system}.default.override {
      _7zz = pkgs._7zz-rar;
    })
  ];
  /*
  imports = [./keymap.nix];

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
  */
}
