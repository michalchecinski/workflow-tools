{ config, lib, pkgs, options, ... }: 
with lib; {
  options.modules.python = {
    enable = mkOption { type = types.bool; default = false; };
  };

  config = mkIf config.modules.python.enable {
    home.packages = [ 
      pkgs.python310Packages.pyyaml
      pkgs.python310Packages.kubernetes
    ];
  };

}
