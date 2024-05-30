#!/usr/bin.env groovy

library identifier: 'jenkins-shared-library@master', retriever: modernSCM(
    [$class: 'GitSCMSource',
    remote: 'https://gitlab.com/twn-devops-bootcamp/latest/09-aws/jenkins-shared-library.git',
    credentialsID: 'gitlab-credentials'
    ]
)

pipeline {   
    agent any
     tools {
        maven 'Maven'
    }
   environment {
        IMAGE_NAME = 'jakai/demo-app:java-maven-app'
    }

    stages {
        stage("build app") {
            steps {
                script {
                    echo 'building application jar...'
                    buildJar()
                }
            }
        }
        stage("build image") {
            steps {
                script {
                    echo 'building the docker image...'
                    buildImage(env.IMAGE_NAME)
                    dockerLogin()
                    dockerPush(env.IMAGE_NAME)

                }
            }
        }

        stage("deploy") {
            steps {
                script {
                    def dockerComposeCMD = "docker-compose -f docker-compose.yaml up --detach"
                    sshagent(['azure-server-key']) {
                        sh "scp docker-compose.yaml azureuser@20.211.145.205:/home/azureuser"
                        sh "ssh -o StrictHostKeyChecking=no azureuser@20.211.145.205 ${dockerComposeCMD}"
}
                }
            }
        }               
    }
} 
