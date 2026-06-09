{
  description = "Basic Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        # IMPORTANT: To ensure compatibility with the latest Firefox version, use nixpkgs-unstable.
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #noctalia-qs = {
    #  url = "github:noctalia-dev/noctalia-qs";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf.url = "github:notashelf/nvf";

    catppuccin.url = "github:catppuccin/nix";

    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #    mcsr-nixos = {
    #      url = "https://git.uku3lig.net/uku/mcsr-nixos/archive/main.tar.gz";
    #      inputs.nixpkgs.follows = "nixpkgs";
    #    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    zen-browser,
    nvf,
    catppuccin,
    sops-nix,
    ...
  } @ inputs: {
    nixosConfigurations.nixos-btw = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};
      modules = [
        ./nixos/configuration.nix
        nvf.nixosModules.default
        ./programs/noctalia.nix
        sops-nix.nixosModules.sops
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.users.catab.imports = [
            ./home.nix
          ];

          home-manager.extraSpecialArgs = {inherit inputs;};
        }
      ];
    };
  };
}
