#!/bin/bash

REPO="account-financial-tools"
MODULE="account_asset_management"
USER_ORG="apps2grow"

function start {
  git clone https://github.com/OCA/$REPO -b 12.0
  cd $REPO
  git checkout -b 12.0-mig-$MODULE origin/12.0
  git format-patch --keep-subject --stdout origin/12.0..origin/11.0 -- $MODULE | git am -3 --keep
}

function finish {
  git add --all
  git commit -m "[MIG] $MODULE: Migration to 12.0"
  git remote add $USER_ORG git@github.com:$USER_ORG/$REPO.git # This mode requires an SSH key in the GitHub account
  #... or ....
  #git remote add $USER_ORG https://github.com/$USER_ORG/$REPO.git # This will required to enter user/password each time
  git push $USER_ORG 12.0-mig-$MODULE --set-upstream
}