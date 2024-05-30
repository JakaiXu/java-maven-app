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
                    def shellCmd = "bash ./server-cmds.sh ${IMAGE_NAME}"
                    sshagent(['azure-server-key']) {
                        sh "scp server-cmds.sh azureuser@20.211.145.205:/home/azureuser"
                        sh "scp docker-compose.yaml azureuser@20.211.145.205:/home/azureuser"
                        sh "ssh -o StrictHostKeyChecking=no azureuser@20.211.145.205 ${shellCmd}"
}
                }
            }
        }               
    }
} 
