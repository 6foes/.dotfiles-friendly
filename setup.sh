#!/bin/bash

set -e

echo ".................................."
echo "........... setting up ..........."
echo "To ensure correct installation. see for below line at the end"
echo "........... ok ............"
echo ".................................."

echo ""
echo "....... wezterm | configuring ......."
if [ ! -d $HOME/.config/wezterm ]; then
    mkdir -p $HOME/.config/wezterm
    echo " wezterm | $HOME/.config/wezterm folder created"
else
    echo " wezterm | $HOME/.config/wezterm exists!"
fi
cp -r .config/wezterm $HOME/.config/
echo "....... wezterm | ok ......."

echo ""
echo "........... ok ..........."
