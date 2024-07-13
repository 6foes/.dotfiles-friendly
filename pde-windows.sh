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

echo "....... windows portables | ok ......."

echo ""
echo "....... windows cmd,shortcuts | configuring ......."
if [ ! -d $HOME/.windows-cmds-shortcuts ]; then
    mkdir $HOME/.windows-cmds-shortcuts
    echo " wezterm | $HOME/.windows-cmds-shortcuts folder created"
else
    echo " wezterm | $HOME/.windows-cmds-shortcuts exists!"
fi

cp -r .windows-cmds-shortcuts/ $HOME
echo "....... windows cmd,shortcuts | ok ......."


echo ""
echo "....... windows portables | configuring ......."
if [ ! -d $HOME/.portables ]; then
    # mkdir $HOME/.portables
    git clone git@github.com:6foes/.portables.git $HOME/.portables
    cd $HOME/.portables
    tar -xzf *.tar.gz
    rm *.tar.gz
    echo " windows portables | $HOME/.portables folder created"
else
    echo " windows portables | $HOME/.portables exists!"
fi  


echo ""
echo "now your are $HOME folder"
echo "........... ok ..........."
