# scp ~/.ssh/id_rsa.pub root@159.65.171.116:~/.ssh/authorized_keys
# ssh root@159.65.171.116 'adduser deploy && adduser deploy sudo'
# ssh deploy@159.65.171.116 mkdir /home/deploy/.ssh
# scp ~/.ssh/id_rsa.pub deploy@159.65.171.116:~/.ssh/authorized_keys
# scp ./launch.sh deploy@159.65.171.116:~/launch.sh
# ssh deploy@159.65.171.116 '. launch.sh'

set -e

# Adding Node.js repository
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
# Adding Yarn repository
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo add-apt-repository ppa:chris-lea/redis-server
# Refresh our packages list with the new repositories
sudo apt-get update
# Install our dependencies for compiiling Ruby along with Node.js and Yarn
sudo apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev dirmngr gnupg apt-transport-https ca-certificates redis-server redis-tools nodejs yarn

git clone https://github.com/rbenv/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
git clone https://github.com/rbenv/rbenv-vars.git ~/.rbenv/plugins/rbenv-vars
. ~/.bashrc
rbenv install 3.0.1
rbenv global 3.0.1
ruby -v
# ruby 3.0.1

# This installs the latest Bundler, currently 2.x.
gem install bundler
# For older apps that require Bundler 1.x, you can install it as well.
gem install bundler -v 1.17.3
# Test and make sure bundler is installed correctly, you should see a version number.
bundle -v
# Bundler version 2.0

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7
sudo sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger focal main > /etc/apt/sources.list.d/passenger.list'
sudo apt-get update
sudo apt-get install -y nginx-extras libnginx-mod-http-passenger
if [ ! -f /etc/nginx/modules-enabled/50-mod-http-passenger.conf ]; then sudo ln -s /usr/share/nginx/modules-available/mod-http-passenger.load /etc/nginx/modules-enabled/50-mod-http-passenger.conf ; fi
sudo ls /etc/nginx/conf.d/mod-http-passenger.conf

echo "Please change line in /etc/nginx/conf.d/mod-http-passenger.conf"
echo "passenger_ruby /home/deploy/.rbenv/shims/ruby;"
echo "...and run: sudo service nginx start"
