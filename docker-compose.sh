#!/bin/bash

export ODOO_ROOT="$HOME/odoo"
export ODOO_VERSION="10.0"
export UID

if [ ! -d $ODOO_ROOT ]; then

    mkdir \
    $ODOO_ROOT \
    $ODOO_ROOT/$ODOO_VERSION \
    $ODOO_ROOT/$ODOO_VERSION/addons \
    $ODOO_ROOT/$ODOO_VERSION/filestore \
    $ODOO_ROOT/$ODOO_VERSION/letsencrypt \
    $ODOO_ROOT/$ODOO_VERSION/scripts \
    $ODOO_ROOT/$ODOO_VERSION/sessions \
    $ODOO_ROOT/$ODOO_VERSION/ssh \
    $ODOO_ROOT/postgres \
    $ODOO_ROOT/postgres/data \
    $ODOO_ROOT/postgres/init

    #sudo chown $UID:$UID -R $ODOO_ROOT/postgres

    cp ./odoo/startup.sh $ODOO_ROOT/$ODOO_VERSION/scripts
    cp ./odoo/known_hosts $ODOO_ROOT/$ODOO_VERSION/ssh
    cp ~/.ssh/id_rsa $ODOO_ROOT/$ODOO_VERSION/ssh
    cp ~/.ssh/letsencrypt.key $ODOO_ROOT/$ODOO_VERSION/letsencrypt
    eval "echo \"$(<./postgres/init.sql)\"" > $ODOO_ROOT/postgres/init/init.sql

fi

sudo ODOO_ROOT=$ODOO_ROOT ODOO_VERSION=$ODOO_VERSION UID=$UID docker-compose "$@"

