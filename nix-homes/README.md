# Not just dotfiles

I have recently started using NixOS for my daily driver. I really liked the idea of having repeatable 
OS installs that are exactly the same every single time. If I need to reinstall the OS for any reason,
the resulting machine setup will be exactly like it was before the wipe. 

Home Manager was really exciting to see for management of my personal user setup. I found my optimal 
flow was the complete separation of system and user configurations. The system installs and manages any
system level packages (like the wifi, bluetooth, sound, X11, etc). It has been decided that X11 will be
used for all users at this point.

## System Install with Home Manager
Install the system as noted in the NixOS config files. This will install the base NixOS system

1. From the `root` user, right after the `nixos-rebuild switch`, set the `joseph` user password:
   `passwd joseph`
2. Switch to TTY2 and login to the `joseph` user
3. `nix-shell -p vim git`
4. `git clone https://github.com/joseph-flinn/workflow-tools.git`
5. `mkdir -p ~/.config/nixpkgs`
6. `ln -s ~/workflow-tools/nix-homes/framework-joseph.git ~/.config/nixpkgs/home.nix`
7. `home-manager switch`
