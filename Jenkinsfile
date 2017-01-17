#!groovy

node {


    git credentialsId: 'thalhallajenkins-github', url: 'https://github.com/Thalhalla/meanshop.git'
    currentBuild.result = "SUCCESS"

    try {

       stage('Checkout') {

            checkout scm

      }
       stage('NPM Install') {

            env.NODE_ENV = "test"

            print "Environment will be : ${env.NODE_ENV}"

            sh "mkdir -p ${WORKSPACE}/data/db"
            sh '''#!/bin/bash -l
export PATH="$PATH:$HOME/.rvm/bin"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
export NVM_DIR="/var/jenkins_home/.nvm"
source "$NVM_DIR/nvm.sh"
npm prune
npm install
npm install -g bower grunt-cli phantomjs
'''

      }
       stage('Gem Install') {

            env.NODE_ENV = "test"

            print "Environment will be : ${env.NODE_ENV}"

            sh "mkdir -p ${WORKSPACE}/data/db"
            sh '''#!/bin/bash -l
export PATH="$PATH:$HOME/.rvm/bin"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
export NVM_DIR="/var/jenkins_home/.nvm"
source "$NVM_DIR/nvm.sh"
gem install sass
'''

      }
       stage('Bower Install') {

            env.NODE_ENV = "test"

            print "Environment will be : ${env.NODE_ENV}"

            sh "mkdir -p ${WORKSPACE}/data/db"
            sh '''#!/bin/bash -l
export PATH="$PATH:$HOME/.rvm/bin"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
export NVM_DIR="/var/jenkins_home/.nvm"
source "$NVM_DIR/nvm.sh"
bower install
'''

      }
       stage('Test') {

            env.NODE_ENV = "test"

            print "Environment will be : ${env.NODE_ENV}"

            sh "mkdir -p ${WORKSPACE}/data/db"
            sh "mongod --quiet --fork --noauth --pidfilepath ${WORKSPACE}/mongopid --logpath ${WORKSPACE}/data/log --dbpath ${WORKSPACE}/data/db"
            sh '''#!/bin/bash -l
export PATH="$PATH:$HOME/.rvm/bin"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
export NVM_DIR="/var/jenkins_home/.nvm"
source "$NVM_DIR/nvm.sh"
export DISPLAY=:99.0
# sh -e /etc/init.d/xvfb start
VFB_WHD=${XVFB_WHD:-1280x720x16}
# Start Xvfb
Xvfb :99 -ac -screen 0 $XVFB_WHD &
xvfb=$!
grunt test
'''
            sh "kill -HUP `cat ${WORKSPACE}/mongopid`"

      }
       stage('Build Docker') {

            echo "./dockerBuild.sh"

      }
       stage('Deploy') {

            echo 'Push to Repo'
            sh 'echo "./dockerPushToRepo.sh"'

            echo 'ssh to web server and tell it to pull new image'
            sh 'echo ssh builder@balder.thalhalla.com /usr/local/bin/dockerRun.sh'

      }
       stage('Cleanup') {

            echo 'prune and cleanup'
            sh 'npm prune'
            sh 'rm node_modules -rf'
            echo 'done'

      }
    }


    catch (err) {

        currentBuild.result = "FAILURE"

        throw err
    }

}
