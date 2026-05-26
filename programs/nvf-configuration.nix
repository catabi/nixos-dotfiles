{pkgs, ...}: {
  programs.nvf = {
    enable = true;

    # Your settings need to go into the settings attribute set
    # most settings are documented in the appendix
    settings = {
      vim = {
        theme = {
          enable = true;
          name = "catppuccin";
          style = "mocha";
        };
        ui = {
          borders.enable = true;
          noice.enable = true;
          colorizer.enable = true;
        };
        statusline.lualine = {
          enable = true;
          theme = "catppuccin";
        };
        snippets.luasnip.enable = true;

        filetree = {
          neo-tree = {
            enable = true;
          };
        };
        tabline = {
          nvimBufferline.enable = true;
        };
        binds = {
          whichKey.enable = true;
          cheatsheet.enable = true;
        };
        # nvim-docs-view.enable = true;
        spellcheck.enable = true;
        telescope.enable = true;
        autocomplete.nvim-cmp.enable = true;
        viAlias = false;
        vimAlias = true;
        lsp = {
          enable = true;
          formatOnSave = true;
        };
        languages = {
          enableTreesitter = true;
          enableFormat = true;

          nix.enable = true;
          python.enable = true;
          bash.enable = true;
        };
        options = {
          tabstop = 2;
          shiftwidth = 2;
          wrap = true;
          linebreak = true;
        };
      };
    };
  };
}
