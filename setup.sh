#! /usr/bin/bash


sudo apt update
sudo apt install nala -y
sudo nala install git curl fzf libssl-dev libreadline-dev zlib1g-dev autoconf bison build-essential libyaml-dev libreadline-dev libncurses5-dev libffi-dev libgdbm-dev -y
sudo nala update

if ! node -v &>/dev/null; then
    node_version=$(printf '%s\n' "18" "16" "14" "12" | fzf --border --height=10 --reverse --no-info --prompt="Select nodejs version to install")
fi
node_installed=$(node -v)

if [ "$node_installed" ]; then
    echo "node $node_installed already installed"
else

    if [ -z "$node_version" ]; then
        echo "No version selected. Exiting."
        exit 1
    fi
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
    source ~/.bashrc        
    source ~/.nvm/nvm.sh

    nvm install $node_version
    nvm use $node_version

    npm install -g yarn

    echo "node $(node -v) & yarn v$(yarn -v) is installed in the system"
fi

sudo nala update

echo "ruby and rails installation begin ========================"
if ! rbenv -v &>/dev/null; then

    curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
    echo 'eval "$(rbenv init -)"' >> ~/.bashrc
    source ~/.bashrc
fi

type rbenv

if [ $(type rbenv) ]; then
    ruby_version=$(rbenv install --list |fzf --border --height=10 --reverse --no-info --prompt="Select ruby version to install")

    rbenv install $ruby_version
    rbenv global $ruby_version

    rails_version=$(gem search '^rails$' --remote --all | grep -Eo '([0-9]\.)+[0-9]' | fzf --border --height=30 --reverse --no-info --prompt="Select rails version to install")

    gem install bundler
    gem install rails -v $rails_version
else
    echo "Close and open the terminal and rerun the command to initialize rbenv"
    exit 1
fi

