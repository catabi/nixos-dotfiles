{
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [
    inputs.zen-browser.homeModules.beta #beta branch of zenbrowser
    #./programs/yazi.nix
  ];

  home.username = "catab";
  home.homeDirectory = "/home/catab";
  home.stateVersion = "26.11";

  #home.packages = with pkgs; [
  ##
  #];
  programs.git = {
    enable = true;

    settings = {
      init.defaultBranch = "main";
      user.name = "catabi";
      user.email = "leriex123@gmail.com";
    };
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = [
        "org.kde.dolphin.desktop"
      ]; # Replace with your file manager's desktop file
      "video/mp4" = ["mpv.desktop"];

      "image/gif" = ["qimgv.desktop"];
      "image/jpeg" = ["qimgv.desktop"];
      "image/png" = ["qimgv.desktop"];
      "application/pdf" = ["zen-beta.desktop"];

      "text/markdown" = ["nvim.desktop"];
      "text/plain" = ["nvim.desktop"];
      "text/yaml" = ["nvim.desktop"];
      "text/html" = ["zen-beta.desktop"];
      "x-scheme-handler/http" = ["zen-beta.desktop"];
      "x-scheme-handler/https" = ["zen-beta.desktop"];
      "x-scheme-handler/about" = ["zen-beta.desktop"];
      "x-scheme-handler/unknown" = ["zen-beta.desktop"];

      "audio/wav" = ["audacity.desktop"];

      #"application/vnd.openxmlformats-officedocument.wordprocessingml.document" = [libreoffice...
    };
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      nc = "nvim ~/.dots/nixos/configuration.nix";
      nrs = "sudo nixos-rebuild switch --flake ~/.dots#nixos-btw";
      nrsu = "sudo nixos-rebuild switch --flake ~/.dots#nixos-btw --upgrade";
      nfu = "sudo nix flake update --flake ~/.dots"; # nix flake update
      hypr = "nvim ~/.dots/config/mango/config.conf";
      binds = "nvim ~/.dots/config/mango/keybinds.conf";
      wr = "nvim ~/.dots/config/mango/windowrules.conf";
      as = "nvim ~/.dots/config/mango/autostart.conf";
      home = "nvim ~/.dots/home.nix";
      flake = "nvim ~/.dots/flake.nix";
      pkgs = "nvim ~/.dots/programs/common.nix"; #nixpkgs
      ns = "nix-shell";
      p = "python3 ";
      m = "~/.dots/scripts/mount.sh";
      mg = "mango -c ~/.dots/config/mango/config.conf";
      upg = "~/.dots/scripts/update-and-push.sh"; #update push git
      sp = "~/.dots/scripts/mangoscratch.sh";
    };

    initExtra = ''
        export PS1='\[\e[38;5;166m\]\u \[\e[38;5;204m\]\w\[\e[0m\] \[\e[38;5;214m\]\$\[\e[0m\] \[\e[38;5;166m\]>\[\e[0m\] '
      # bash-prompt-generator.org
      fastfetch
    '';
  };

  home.file.".config/alacritty".source = ./config/alacritty;
  home.file.".config/hypr".source = ./config/hypr;
  home.file.".config/easyeffects".source = ./config/easyeffects;
  home.file.".config/yazi".source = ./programs/yazi;

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      #    gtk-theme = "Catppuccin-Macchiato-Standard-Blue-Dark";
      color-scheme = "prefer-dark";
    };
  };

  home.pointerCursor = {
    enable = true;
    package = pkgs.catppuccin-cursors.mochaPeach;
    name = "catppuccin-mocha-peach-cursors";
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  programs.zen-browser.enable = true;
  programs.home-manager.enable = true;
}
