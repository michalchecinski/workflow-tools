{ config, pkgs, ... }: {

  imports = [
    ./modules/settings.nix
    ./modules/base.nix
    ./modules/dwm.nix
    ./modules/neovim.nix
    ./modules/arduino.nix
    ./modules/python.nix
  ];

  settings.username = "joseph";

  modules.base.enable = true;
  modules.dwm.enable = true;
  modules.neovim.enable = true;
  modules.arduino.enable = true;
  modules.python.enable = true;

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    ansible
    argo
    beekeeper-studio
    brave
    dmenu
    docker-client
    hledger
    joplin-desktop
    k9s
    kubectl
    kubernetes-helm
    kubeseal
    ranger
    spotify
    vault
    xflux
  ];
}
