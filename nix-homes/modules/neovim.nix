{ config, lib, pkgs, ... }:

with lib; {
  options.modules.neovim = {
    enable = mkOption { type = types.bool; default = false; };
  };
  
  config = mkIf config.modules.neovim.enable {
    home.file.".dotfiles" = {
      source = builtins.fetchGit {
        url = "https://github.com/joseph-flinn/dotfiles";
        ref = "main";
        sparseCheckout = ''
        '';
	    rev = "0ab4cf4b95e9b941d18bb80f16367a1f061b6b12";
      };
    };

    programs.neovim = {
      enable = true;
      
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;

      withNodeJs = true;
      withPython3 = true;

      plugins = [];
      extraConfig = ''
        let g:config_dir='~/.dotfiles/nvim'
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
