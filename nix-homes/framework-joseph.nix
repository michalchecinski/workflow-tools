{ config, pkgs, ... }: {

  imports = [
    ./modules/base.nix
    ./modules/dwm.nix
    ./modules/neovim.nix
  ];

  modules.base.enable = true;
  modules.dwm.enable = true;
  modules.neovim.enable = true;

  home.packages = with pkgs; [
    dmenu
    brave
    hledger
  ];
}
