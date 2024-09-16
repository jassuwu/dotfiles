{
  description = "Top level NixOS Flake";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    #nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";

    # Unstable Packages
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home Manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Templ
    templ.url = "github:a-h/templ";

    # Ags
    ags.url = "github:Aylur/ags";

    # Matugen
    matugen.url = "github:InioX/matugen?ref=v2.2.0";

    # NixVim
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    # Zen browser
    zen-browser.url = "github:MarceColl/zen-browser-flake";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    templ,
    nixpkgs-unstable,
    ags,
    ...
  } @ inputs: let
    inherit (self) outputs;

    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];

    hosts = [
      "nixmsi"
    ];

    forAllSystems = fn: nixpkgs.lib.genAttrs systems (system: fn {pkgs = import nixpkgs {inherit system;};});
  in {
    overlays = import ./overlays {inherit inputs;};

    formatter = forAllSystems ({pkgs}: pkgs.alejandra);

    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});

    nixosConfigurations = builtins.listToAttrs (map (name: {
        name = name;
        value = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
            meta = {hostname = name;};
          };
          system = "x86_64-linux";
          modules = [
            # System Specific
            ./machines/${name}/hardware-configuration.nix
            # General
            ./configuration.nix
            # Home Manager
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.jass = import ./home/home.nix;
              home-manager.extraSpecialArgs = {inherit inputs;};
	            home-manager.backupFileExtension = "old";
            }
          ];
        };
      })
      hosts);
  };
}
