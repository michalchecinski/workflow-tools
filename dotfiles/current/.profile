# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

add_to_path () {
    # Args:
    #   $1 -> directory
    if [ -d "$1" ] ; then
        PATH="$1:$PATH"
    fi
}

# set PATH so it includes user's private bin if it exists
add_to_path "$HOME/bin"
add_to_path "$HOME/.local/bin"
add_to_path "$HOME/.tfenv/bin"
add_to_path "$HOME/.poetry/bin"
add_to_path "$HOME/.cargo/bin"

export VISUAL=vim
export EDITOR="$VISUAL"

export PYENV_ROOT="$HOME/.pyenv"
add_to_path "$PYENV_ROOT/bin"

export DOTNET_ROOT=$HOME/dotnet
add_to_path "$HOME/dotnet"

add_to_path "${KREW_ROOT:-$HOME/.krew}/bin"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

add_to_path "$HOME/workflow-tools/bin"
