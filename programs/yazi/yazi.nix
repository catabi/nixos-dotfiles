{ lib, ... }: {
  programs.yazi = {
    enable = true;
    settings = {
      yazi = lib.importTOML ./yazi.toml;
      #theme = lib.importTOML ./theme.toml;
      #keymap = lib.importTOML ./keymap.toml;
    };
  };
}
