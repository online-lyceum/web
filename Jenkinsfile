#!groovy

properties([disableConcurrentBuilds()])

pipeline {
    agent any
    options {
        buildDiscarder(logRotator(numToKeepStr: '5', artifactNumToKeepStr: '5'))
        timestamps()
    }
    stages {
        stage("Build image") {
            steps {
                sh 'docker build -t web-app:test .'
            }
        }
        stage("Run images") {
            steps {
                sh 'docker-compose up -d -f ./docker-compose.prod.yml'
            }
        }
    }
}
