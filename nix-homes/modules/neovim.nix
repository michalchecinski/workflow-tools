{ config, lib, pkgs, ... }:

with lib; {
  options.modules.neovim = {
    enable = mkOption { type = types.bool; default = false; };
  };
  
  config = mkIf config.modules.neovim.enable {
    programs.neovim = {
      enable = true;
      
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;

      withNodeJs = true;
      withPython3 = true;

      plugins = [];
      extraConfig = ''
        let g:config_dir='~/workflow-tools/nix-homes/modules/neovim'
        let g:plugin_dir='~/.vim/plugged'
        execute "exe 'source' '" . g:config_dir . "/init.vim'"
      '';
    };

    home.sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };
}
