pipeline {
    agent any
    
    environment {
        CONTAINER_CREATED = false
        CLIENT_SERVER = '52.91.38.54' // Replace 'your-client-server' with the hostname or IP address of your client server
        SSH_CREDENTIALS = 'ubuntu' // Replace 'your-ssh-credentials' with the name of your SSH credentials configured in Jenkins
    }
    
    stages {
        stage('Build and Push Docker Image') {
            steps {
                script {
                    withCredentials([string(credentialsId: 'Galvinaries', variable: 'dockerhubpwd')]) {
                        // Calculate the version based on the build number
                        def VERSION = "${env.BUILD_NUMBER}"

                        // Build the Docker image using the Dockerfile in the current directory
                        sh "docker build -t my-docker-image:${VERSION} ."

                        // Tag the Docker image with the repository and version
                        sh "docker tag my-docker-image:${VERSION} galvinaries/simplyfiday01:${VERSION}"

                        // Login to Docker Hub securely
                        sh "echo ${dockerhubpwd} | docker login -u Galvinaries --password-stdin"

                        // Push the Docker image to the Docker Hub repository
                        sh "docker push galvinaries/simplyfiday01:${VERSION}"
                    }
                }
            }
        }
    }
}
