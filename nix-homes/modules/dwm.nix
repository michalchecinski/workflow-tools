{ config, lib, pkgs, ... }:

with lib; {
  options.modules.dwm = {
    enable = mkOption { type = types.bool; default = false; };
  };

  config = mkIf config.modules.dwm.enable {
    nixpkgs.overlays = with pkgs; [
      (self: super: {
        dwm = super.dwm.overrideAttrs (oldAttrs: rec {
          patches = [
            #./path/to/my-dwm-patch.patch
          ];
          configFile = super.writeText "config.h" (builtins.readFile ./dwm/dwm-config.h);
          postPatch = oldAttrs.postPatch or "" + "\necho 'Using own config file...'\n cp ${configFile} config.def.h";
        });
        st = super.st.overrideAttrs (oldAttrs: rec {
          patches = [];
          configFile = super.writeText "config.h" (builtins.readFile ./dwm/st-config.h);
          postPatch = "${oldAttrs.postPatch}\ncp ${configFile} config.def.h\n";
        });
      })
    ];

    home.packages = with pkgs; [
      dwm
      st
      pamixer
    ];

    xsession.enable = true;
    xsession.initExtra = ''
      ~/workflow-tools/nix-homes/modules/dwm/dwm_bar/dwm_bar.sh &
      xflux -z 99208
    '';
    xsession.windowManager.command = "dwm";

    #services.picom.enable = true;
    #services.picom.shadow = false;
  };#
} 

