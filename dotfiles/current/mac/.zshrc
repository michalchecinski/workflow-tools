##############
#  bindkeys  #
##############
bindkey -v
bindkey "^R" history-incremental-pattern-search-backward


###################
#  session setup  #
###################
if command -v pyenv 1>/dev/null 2>&1; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init --path)"
fi

#export DOTNET_ROOT=$HOME/dotnet
export DOTNET_ROOT="/usr/local/opt/dotnet/libexec"
export GOPATH=$HOME/go
export DOCKER_HOST=tcp://localhost:2375

. ~/.env_setup

# add_to_path is from .env_setup
add_to_path "$HOME/Library/Python/3.9/bin"
add_to_path "$HOME/dotnet"
add_to_path "$HOME/.dotnet/tools"
add_to_path "$HOME/go/bin"
add_to_path "/usr/local/opt/curl/bin"
add_to_path "/usr/local/opt/crowdin@3/bin"
add_to_path "$HOME/bitwarden/bin"

# Load custom funcitons
if [ -f ~/.functions ]; then
    . ~/.functions
fi
if [ -f ~/.zsh_functions ]; then
    . ~/.zsh_functions
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/usr/local/google/google-cloud-sdk/path.zsh.inc' ]; then . '/usr/local/google/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
#if [ -f '/usr/local/google/google-cloud-sdk/completion.zsh.inc' ]; then . '/usr/local/google/google-cloud-sdk/completion.zsh.inc'; fi

kube_configs=(~/.kube/configs/*)
export KUBECONFIG=$(IFS=: ; echo "${kube_configs[*]}")

[[ /usr/local/bin/kubectl ]] && source <(kubectl completion zsh) # add autocomplete permanently to your zsh shell


#############
#  Aliases  #
#############
alias tf="terraform"
alias cksp="ispell -x -p ~/.ispell_english"
alias vim="nvim"
alias tg="terragrunt"

if [ -f ~/workflow-tools/bin/.aliases ]; then
    . ~/workflow-tools/bin/.aliases
fi
