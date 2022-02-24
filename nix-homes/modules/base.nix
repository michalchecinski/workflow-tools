{ config, lib, pkgs, ... }: 

with lib; {
  imports = [];

  options.modules.base = {
    enable = mkOption { type = types.bool; default = false; };
    username = mkOption { type = types.string; default = "joseph"; };
  };

  config = mkIf config.modules.base.enable {
    home.packages = with pkgs; [
      bash
      git
      tmux
      tree
      htop
      openssh
      openssl
    ];
  };
}
