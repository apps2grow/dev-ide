#!/bin/bash
# https://github.com/Elico-Corp/odoo-docker/blob/10.0/bin/boot


# Start pycharm
nohup /usr/bin/pycharm-community &>/dev/null &


# Create SSH folder and copy known_hosts
odoo_user='target-odoo-user'

function _setup_ssh_key {
    # SSH config folder in $HOME folder of target user
    ssh_folder=$( getent passwd "$odoo_user" | cut -d: -f6 )/.ssh

    # SSH config folder already exists when container has been restarted
    if [ ! -d "$ssh_folder" ]; then
        # Create SSH config folder
        sudo -i -u "$odoo_user" mkdir "$ssh_folder"

        # Copy SSH private key from /opt/odoo/ssh
        sudo -i -u "$odoo_user" cp /opt/odoo/ssh/id_rsa "$ssh_folder"
        sudo -i -u "$odoo_user" cp /opt/odoo/ssh/known_hosts "$ssh_folder"

        #echo $log_src[`date +%F.%H:%M:%S`]' Scanning GitHub key...'
        ## Hide ssh-keyscan stderr output since it's actually log message
        #ssh-keyscan github.com 2> /dev/null | \
        #    sudo -i -u "$odoo_user" tee "$ssh_folder/known_hosts" > /dev/null

        # Bind SSH key to GitHub host
        echo "host github.com
                HostName github.com
                User git
                IdentityFile $ssh_folder/id_rsa
host bitbucket.org
                HostName bitbucket.org
                User norlinhenrik
                IdentityFile $ssh_folder/id_rsa" | \
            sudo -i -u "$odoo_user" tee "$ssh_folder/config" > /dev/null

        ## Secure SSH key
        chmod 400 "$ssh_folder/id_rsa"
    fi
}
_setup_ssh_key
