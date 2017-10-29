#!/bin/bash
set -ev

#-------------------------------------------------------------------------------
# Choose the repo
#-------------------------------------------------------------------------------
export JHIPSTER_REPO=https://github.com/jhipster/generator-jhipster.git
export JHIPSTER_BRANCH=master

#-------------------------------------------------------------------------------
# Install JHipster
#-------------------------------------------------------------------------------
cd "$HOME"
git clone $JHIPSTER_REPO generator-jhipster
cd generator-jhipster
if [ "$JHIPSTER_BRANCH" == "latest" ]; then
    LATEST=$(git describe --abbrev=0)
    git checkout -b $LATEST $LATEST
elif [ "$JHIPSTER_BRANCH" != "master" ]; then
    git checkout -b $JHIPSTER_BRANCH origin/$JHIPSTER_BRANCH
fi
git --no-pager log -n 10 --graph --pretty='%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit
npm install
npm link

#-------------------------------------------------------------------------------
# Install JHipster
#-------------------------------------------------------------------------------
cd "$TRAVIS_BUILD_DIR"
npm install
npm link
npm link generator-jhipster
npm run lint
