#!/bin/sh
# copies dot files into users home

echo "Validate whether brew is installed "
which -s brew
if [[ $? != 0 ]] ; then
    echo "Install brew"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    echo "Update brew..."
    brew update
fi


CURENT_DIR=$(pwd -P)
DOTFILES_DIR=$(pwd -P)
echo "Create symlink for dotfiles..."
for DOTFILE in *; do
    HOME_DOT_FILE="$HOME/.$DOTFILE"
    DOTFILE_PATH="$DOTFILES_DIR/$DOTFILE"

    # Don't copy  current folder, text and md
    echo $DOTFILE | egrep -q '(^script$|\.txt$|\.md$|\.sh$)' && continue

    if [ -L "$HOME_DOT_FILE" ] && ! [ -d $DOTFILE ]
    then
      ln -sfv "$DOTFILE_PATH" "$HOME_DOT_FILE"
    else
      rm -rv "$HOME_DOT_FILE"
      ln -sv "$DOTFILE_PATH" "$HOME_DOT_FILE"
    fi
done

echo "Install bundle"

brew bundle

echo "Setup Oh My Zsh..."

sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions > /dev/null 2>&1

pip install virtualenvwrapper > /dev/null 2>&1



