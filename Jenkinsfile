#!groovy

node {


    git credentialsId: 'thalhallajenkins-github', url: 'https://github.com/Thalhalla/meanshop.git'
    currentBuild.result = "SUCCESS"

    env.NODE_ENV = "test"
    env.NVM_DIR="/var/jenkins_home/.nvm"
    env.PATH="$PATH:$HOME/.rvm/bin"

    try {

       stage('Checkout') {

            checkout scm

      }
       stage('NPM Install') {

            print "Environment will be : ${env.NODE_ENV}"

            sh '''#!/bin/bash -l
            [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
            source "$NVM_DIR/nvm.sh"
            npm prune
            npm install -g yo bower grunt-cli
            npm install -g phantomjs-prebuilt --save-dev
            npm install
            '''
      }
       stage('Gem Install') {

            print "Environment will be : ${env.NODE_ENV}"

            sh '''#!/bin/bash -l
            [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
            source "$NVM_DIR/nvm.sh"
            rvm list
            gem install sass
            '''
      }
       stage('Bower Install') {

            print "Environment will be : ${env.NODE_ENV}"

            sh '''#!/bin/bash -l
            [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
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
            [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
            source "$NVM_DIR/nvm.sh"
            export DISPLAY=:99
            XVFB_WHD=${XVFB_WHD:-1280x720x16}
            Xvfb :99 -ac -screen 0 $XVFB_WHD -nolisten tcp &
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
            sh './dockerPushToRepo.sh'
            sh 'rancher ps'
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

        sh "kill -HUP `cat ${WORKSPACE}/mongopid`"

        throw err
    }

}
