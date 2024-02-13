{
  description = "Ondsel package from AppImage";

  inputs = {
    ondsel-appimage-x86_64-linux.url = "https://github.com/Ondsel-Development/FreeCAD/releases/download/2024.1.0/Ondsel_ES_2024.1.0.35694-Linux-x86_64.AppImage";
    ondsel-appimage-x86_64-linux.flake = false;
    ondsel-appimage-aarch64-linux.url = "https://github.com/Ondsel-Development/FreeCAD/releases/download/2024.1.0/Ondsel_ES_2024.1.0.35694-Linux-aarch64.AppImage";
    ondsel-appimage-aarch64-linux.flake = false;
  };

  outputs = { nixpkgs, ... }@inputs: {
    packages = builtins.listToAttrs (map
      (system: {
        name = system;
        value = with import nixpkgs { inherit system; }; rec {
          ondsel = appimageTools.wrapType2 {
            name = "ondsel";
            src = inputs."ondsel-appimage-${system}";
          };
          default = ondsel;
        };
      }) [ "x86_64-linux" "aarch64-linux" ]);
  };
}
