if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

export VISUAL=vim
export EDITOR="$VISUAL"

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

export PATH="$HOME/Library/Python/3.8/bin:$PATH"
export PATH="$PYENV_ROOT/bin:$PATH"
export PYENV_ROOT="$HOME/.pyenv"

export PATH="$HOME/.poetry/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

export DOTNET_ROOT=$HOME/dotnet
export PATH=$PATH:$HOME/dotnet

export GOPATH=$HOME/go
export PATH=$HOME/go/bin:$PATH

export PATH=$HOME/workflow-tools/bin:$PATH

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/usr/local/google/google-cloud-sdk/path.zsh.inc' ]; then . '/usr/local/google/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/usr/local/google/google-cloud-sdk/completion.zsh.inc' ]; then . '/usr/local/google/google-cloud-sdk/completion.zsh.inc'; fi

kube_configs=(~/.kube/configs/*)
export KUBECONFIG=$(IFS=: ; echo "${kube_configs[*]}")

[[ /usr/local/bin/kubectl ]] && source <(kubectl completion zsh) # add autocomplete permanently to your zsh shell


###############
#             #
#   Aliases   #
#             #
###############
alias tf="terraform"

##########################################
#                                        #
#       custom commands/functions        #
#                                        #
##########################################

##########
#  mtmx  #
##########
function mtmx () {
  # Usage:
  #   mtmx: load default profile in current project directory
  #   mtmx <file-path>: loads specified tmuxp profile
  if [ $1 ]; then
    echo "params: $#"
    echo "file: $1"
  else
    tmuxp load .tmuxp/config/default.yaml
  fi
}

###############
#  kubeclean  #
###############
function kubeclean () {
  pods=$(kubectl get pods --all-namespaces | grep Evicted | awk '{print $2 " --namespace=" $1}')
  echo $pods

  if [[ $pods ]] && [[ "$pods" != "No resources found" ]]; then
    echo "---"
    if [[ -z $1 ]] && [[ "$1" == "-y" ]]; then
      kubectl get pods --all-namespaces | grep Evicted | awk '{print $2 " --namespace=" $1}' | xargs kubectl delete pod
    else
      read "input?Delete listed pods? [N/y] "

      case $input in
        [yY][eE][sS]|[yY])
          kubectl get pods --all-namespaces | grep Evicted | awk '{print $2 " --namespace=" $1}' | xargs kubectl delete pod
          ;;
        *)
          ;;
      esac
    fi
  fi
}
