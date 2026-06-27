{pkgs, ...}: {
  # Fonts
  fonts.packages = with pkgs; [
    rubik
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    nerd-fonts.zed-mono
    nerd-fonts.victor-mono
    nerd-fonts.ubuntu-sans
    nerd-fonts.ubuntu-mono
    nerd-fonts.ubuntu
    nerd-fonts.tinos
    nerd-fonts.terminess-ttf
    nerd-fonts.symbols-only
    nerd-fonts.space-mono
    nerd-fonts.shure-tech-mono
    nerd-fonts.sauce-code-pro
    nerd-fonts.roboto-mono
    nerd-fonts.recursive-mono
    nerd-fonts.proggy-clean-tt
    nerd-fonts.profont
    nerd-fonts.overpass
    nerd-fonts.open-dyslexic
    nerd-fonts.noto
    nerd-fonts.jetbrains-mono
    source-han-sans
    open-sans
  ];
  fonts.fontDir.enable = true;
  fonts = {
    fontconfig = {
      defaultFonts = {
        serif = ["Rubik"];
        sansSerif = ["Rubik"];
      };
    };
  };
}
