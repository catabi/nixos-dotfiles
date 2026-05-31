{
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [
    inputs.zen-browser.homeModules.beta #beta branch of zenbrowser
    inputs.catppuccin.homeModules.catppuccin #catppuccin themes
    #./programs/yazi.nix
  ];

  home.username = "catab";
  home.homeDirectory = "/home/catab";
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    ##
  ];
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
        "alacritty -e yazi"
        "org.kde.dolphin.desktop"
      ]; # Replace with your file manager's desktop file
      "video/mp4" = ["mpv.desktop"];

      "image/gif" = ["qimgv.desktop"];
      "image/jpeg" = ["qimgv.desktop"];
      "image/png" = ["qimgv.desktop"];
      "application/pdf" = ["zen-beta.desktop"];

      "text/markdown" = ["nvim.desktop"];
      "text/plain" = ["nvim.desktop"];

      #"audio.wav"

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
      hypr = "nvim ~/.dots/config/hypr/hyprland.conf";
      binds = "nvim ~/.dots/config/hypr/keybinds.conf";
      wr = "nvim ~/.dots/config/hypr/windowrules.conf";
      as = "nvim ~/.dots/config/hypr/autostart.conf";
      home = "nvim ~/.dots/home.nix";
      flake = "nvim ~/.dots/flake.nix";
      pkgs = "nvim ~/.dots/programs/common.nix"; #nixpkgs
      ns = "nix-shell";
      p = "python3 ";
      m = "~/.dots/scripts/mount.sh";

      upg = "~/.dots/scripts/update-and-push.sh"; #update push git
    };
    profileExtra = ''
      if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
        exec uwsm app -- start-hyprland
      fi
    '';

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
  /*
  gtk = {
    enable = true;

    cursorTheme = {
      package = pkgs.catppuccin-cursors.mochaPeach;
      name = "Catppuccin-Mocha-Peach-Cursors";
    };

    gtk3 = {
      extraConfig.gtk-application-prefer-dark-theme = true;
    };
  };
  */
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      #    gtk-theme = "Catppuccin-Macchiato-Standard-Blue-Dark";
      color-scheme = "prefer-dark";
    };
  };
  catppuccin = {
    enable = true;
    accent = "teal";
    flavor = "mocha";
    gtk = {
      icon.enable = true;
    };

    qt5ct.enable = true;

    rofi.enable = true;
  };

  home.pointerCursor = {
    enable = true;
    package = pkgs.catppuccin-cursors.mochaPeach;
    name = "Catppuccin-Mocha-Peach-Cursors";
    size = 24;
  };

  programs.zen-browser.enable = true;
  programs.home-manager.enable = true;
}
