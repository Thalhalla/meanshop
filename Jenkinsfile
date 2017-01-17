#!groovy

node {


    git credentialsId: 'thalhallajenkins-github', url: 'https://github.com/Thalhalla/meanshop.git'
    currentBuild.result = "SUCCESS"

    try {

       stage('Checkout') {

            checkout scm

      }
       stage('Test') {

            env.NODE_ENV = "test"

            print "Environment will be : ${env.NODE_ENV}"

            sh '''#!/bin/bash -l
            npm prune
            npm install
            export DISPLAY=:99.0
            sh -e /etc/init.d/xvfb start
            npm install -g bower grunt-cli
            gem install sass
            bower install
            grunt test
            '''

      }
       stage('Build Docker') {

            echo "./dockerBuild.sh"'

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
