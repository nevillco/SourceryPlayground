echo "Installing any dependencies..."
gem install bundler
bundle install

echo "Removing old Sourcery directory..."
rm -rf ./Sourcery

echo "Cloning Sourcery..."
bundle exec git clone https://github.com/krzysztofzablocki/Sourcery
