{pkgs, ...}: {
  programs.nvf = {
    enable = true;

    # Your settings need to go into the settings attribute set
    # most settings are documented in the appendix
    settings = {
      vim = {
        startPlugins = [pkgs.vimPlugins.vimtex];
        theme = {
          enable = true;
          name = "catppuccin";
          style = "macchiato";
        };
        ui = {
          borders.enable = true;
          noice.enable = true;
          colorizer.enable = true;
        };
        statusline.lualine = {
          enable = true;
          setupOpts.options.theme = "catppuccin";
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
          sql.enable = true;
          tex.enable = true;
          lua.enable = true;
          java.enable = true;
        };
        options = {
          tabstop = 2;
          shiftwidth = 2;
          wrap = true;
          linebreak = true;
        };
        git = {
          enable = true;
          gitsigns.enable = true;
        };
        extraPlugins = with pkgs.vimPlugins; {
          vimtex = {
            package = vimtex;
            setup = ''
              vim.g.vimtex_view_method = "zathura"
              vim.g.vimtex_compiler_method = "latexmk"
            '';
          };
        };
      };
    };
  };
}
