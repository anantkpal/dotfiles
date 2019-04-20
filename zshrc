# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="bureau"
plugins=(rails git textmate ruby lighthouse)

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
source $ZSH/oh-my-zsh.sh

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
eval "$(nodenv init -)"
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
KUBECONFIG=~/.kube/config
for kubefile in ~/.kube/*.json ; do
 export KUBECONFIG=$KUBECONFIG:$kubefile
done

export WORKON_HOME=~/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh

venv() {
   dir_name=$(basename "$PWD")
   mkvirtualenv $dir_name --python=$(which python3) -a $(pwd)
}

# Aliases
alias k=kubectl
alias wenv=workon
alias denv=deactivate
