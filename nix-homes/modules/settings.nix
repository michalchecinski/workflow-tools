{ config, lib, ... }:
with lib; {
  options.settings = {
    username = mkOption { type = with types; uniq string; default = "joseph"; };
  };
}
