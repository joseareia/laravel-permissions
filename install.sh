#!/bin/bash

if [ ! -d "/opt/" ]; then
    sudo mkdir /opt
fi

if [ -d "/opt/laravel-permissions" ]; then
    sudo rm -r /opt/laravel-permissions
    sudo rm -r /usr/local/bin/laravel-permissions
fi

sudo mkdir /opt/laravel-permissions

echo -e "Copying the files to /opt/laravel-permissions..."
sudo cp --preserve laravel-permissions.sh /opt/laravel-permissions

echo -e "Creating a symlink of 'laravel-permissions.sh' to /usr/local/bin/laravel-permissions..."
sudo ln -s /opt/laravel-permissions/laravel-permissions.sh /usr/local/bin/laravel-permissions

echo -e "[SUCCESS] Installation complete!"
