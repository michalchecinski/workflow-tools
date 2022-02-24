# I had a rough time figuring out how to get a variable into the home.file 
# string. The `options` in a module are loaded into the config (like 
# config.modules.arduino.enable) The "module" key in `framework-joseph.nix` 
# is NOT a keyword. It can be anything. In the `modules/settings.nix` file,
# `options.settings` is set so when imported to this file, `config.settings`
# can be accessed. 
{ config, lib, pkgs, options, ... }: 
with lib; {
  imports = [ ./settings.nix ];

  options.modules.arduino = {
    enable = mkOption { type = types.bool; default = false; };
  };

  config = mkIf config.modules.arduino.enable {
    home.packages = [ pkgs.arduino-cli ];

    home.file."./.arduino15/arduino-cli.yaml".text = ''
      board_manager:
        additional_urls: []
      daemon:
        port: "50051"
      directories:
        data: /home/${config.settings.username}/.arduino15
        downloads: /home/${config.settings.username}/.arduino15/staging
        user: /home/${config.settings.username}/Arduino
      library:
        enable_unsafe_install: false
      logging:
        file: ""
        format: text
        level: info
      metrics:
        addr: :9090
        enabled: true
      sketch:
        always_export_binaries: false
    '';
  };
}
