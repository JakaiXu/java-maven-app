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
                    def dockerCmd = "docker run -p 3088:3088 -d jakai/demo-app:java-maven-app"
                    sshagent(['azure-server-key']) {
                        sh "ssh -o StrictHostKeyChecking=no azureuser@az-vm-with-docker ${dockerCmd}"
}
                }
            }
        }               
    }
} 
