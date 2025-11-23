#!/bin/bash
set -e

# 1. Install Git and Ansible
echo "--> Installing Git and Ansible..."
sudo pacman -Sy --noconfirm git ansible

# 2. Clone the ANSIBLE Repo (Infrastructure)
# REPLACE THIS WITH YOUR ANSIBLE REPO URL
ANSIBLE_REPO="git@github.com:ajcraig99/archi3ansible.git"
SETUP_DIR="$HOME/arch-setup"

if [ -d "$SETUP_DIR" ]; then
    echo "--> Directory exists. Pulling latest..."
    cd "$SETUP_DIR"
    git pull
else
    echo "--> Cloning Ansible setup..."
    git clone "$ANSIBLE_REPO" "$SETUP_DIR"
fi

# 3. Run the Playbook
# This will now:
#   a. Install packages
#   b. Clone your OTHER repo (dotfiles) automatically
#   c. Symlink the config files
echo "--> Running Playbook..."
cd "$SETUP_DIR"
ansible-playbook playbook.yml --ask-become-pass

echo "--> DONE! Reboot to enjoy."
