# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="bureau"
plugins=(rails git textmate ruby lighthouse)
unsetopt nomatch
export JENV_ROOT=$HOME/.jenv
export PYENV_ROOT=$HOME/.pyenv

export PATH="$PYENV_ROOT/bin:$PYENV_ROOT/shims:$HOME/.jenv/bin:$HOME/.jenv/shims:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
source $ZSH/oh-my-zsh.sh
export SHELL=/bin/bash
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
eval "$(nodenv init -)"
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
KUBECONFIG=~/.kube/config
for kubefile in ~/.kube/*.json ; do
 export KUBECONFIG=$KUBECONFIG:$kubefile
done

export VIRTUALENVWRAPPER_PYTHON=$(which python3)
export WORKON_HOME=~/.virtualenvs
export VIRTUALENVWRAPPER_HOOK_DIR=~/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh

venv() {
   dir_name=$(basename "$PWD")
   if [[ ! -d $WORKON_HOME/$dir_name ]]; then
        mkvirtualenv $dir_name --python=$(which python3) -a $(pwd)
   fi
}

venv2() {
   dir_name=$(basename "$PWD")
   if [[ ! -d $WORKON_HOME/$dir_name ]]; then
        mkvirtualenv $dir_name --python=$(which python) -a $(pwd)
   fi
}

get_project_type() {
    project_type=""
    if [[ -f requirements.txt ]]; then
        project_type="python"
    fi
    echo $project_type
}

init_project() {
    type=$1
    name=$2
    if [[ $type == 'python' ]]; then
        venv
    fi
}

cd() {
   builtin cd $1
   dir_name=$(basename "$PWD")
   project_type=$(get_project_type)
#   init_project $project_type $dir_name
}


# Aliases
alias k=kubectl
alias wenv=workon
alias denv=deactivate
