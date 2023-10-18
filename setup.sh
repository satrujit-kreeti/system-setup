#! /bin/sh



sudo apt update && sudo apt install git nala curl libssl-dev libreadline-dev zlib1g-dev autoconf bison build-essential libyaml-dev libreadline-dev libncurses5-dev libffi-dev libgdbm-dev


echo "node installtion begin ================"

wget https://nodejs.org/download/release/v18.17.1/node-v18.17.1-linux-x64.tar.gz
sudo tar -xvf node-v18.17.1-linux-x64.tar.gz
sudo cp -r node-v18.17.1-linux-x64/{bin,include,lib,share} /usr/
export PATH=/usr/node-v18.17.1-linux-x64/bin:$PATH

node --version


curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list


sudo nala update && sudo nala install yarn

echo "node and yarn are successfully installed"

echo "rails installtion begin =============="


curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
source ~/.bashrc

type rbenv



rbenv install 3.2.1
rbenv global 3.2.1


gem install bundler
gem install rails

rails -v


echo "postgres instllation begin ==================="

sudo nala install postgresql postgresql-contrib mysql-server

sudo systemctl start postgresql

sudo systemctl start mysql


