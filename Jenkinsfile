#!/usr/bin.env groovy

pipeline {   
    agent any
    stages {
        stage("test") {
            steps {
                script {
                    echo "Testing the application..."

                }
            }
        }
        stage("build") {
            steps {
                script {
                    echo "Building the application..."
                }
            }
        }

        stage("deploy") {
            steps {
                script {
                    def dockerCmd = "docker run -p 3080:3080 -d jakai/demo-app:java-maven-app"
                    sshagent(['az-vm-server-key']) {
                        sh "ssh -o StrictHostKeyChecking=no azureuser@az-vm-with-docker ${dockerCmd}"
}
                }
            }
        }               
    }
} 
