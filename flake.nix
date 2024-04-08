{
  description = "Ondsel from source";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    ondsel-feedstock = {
      url = "github:Ondsel-Development/freecad-feedstock";
      flake = false;
    };
  };

  outputs = { nixpkgs, ... }@inputs: {
    packages = builtins.listToAttrs (map
      (system: {
        name = system;
        value = with import nixpkgs { inherit system; }; rec {

          default = ondsel;

          ondsel = pkgs.libsForQt5.callPackage ./ondsel.nix {
            boost = python3Packages.boost;
            inherit (python3Packages)
              gitpython
              matplotlib
              pivy
              ply
              pycollada
              pyside2
              pyside2-tools
              python
              pyyaml
              scipy
              shiboken2;
          };

        };
      }) [ "x86_64-linux" "aarch64-linux" ]);
  };
}
