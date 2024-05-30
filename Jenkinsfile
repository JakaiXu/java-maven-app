#!/usr/bin.env groovy

// library identifier: 'jenkins-shared-library@master', retriever: modernSCM(
//     [$class: 'GitSCMSource',
//     remote: 'https://gitlab.com/twn-devops-bootcamp/latest/09-aws/jenkins-shared-library.git',
//     credentialsID: 'gitlab-credentials'
//     ]
// )

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
                    def dockerCmd = "docker run -p 8080:8080 -d jakai/demo-app:java-maven-app"
                    sshagent(['azure-server-key']) {
                        sh "ssh -o StrictHostKeyChecking=no azureuser@20.211.145.205 ${dockerCmd}"
}
                }
            }
        }               
    }
} 
