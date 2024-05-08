pipeline {
    agent any
    
    environment {
        CONTAINER_CREATED = false
        CLIENT_SERVER = '52.91.38.54' // Replace 'your-client-server' with the hostname or IP address of your client server
        SSH_CREDENTIALS = 'ubuntu' // Replace 'your-ssh-credentials' with the name of your SSH credentials configured in Jenkins
    }
    
    stages {
        
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("my-docker-image:${env.BUILD_NUMBER}")
                }
            }
        }
    
        stage('Push Docker Image') {

            steps {
                script {
                    withCredentials([string(credentialsId: 'Galvinaries', variable: 'dockerhubpwd')]) {
                        sh """
                            echo "${dockerhubpwd}" | docker login -u Galvinaries --password-stdin
                            VERSION=$(printf "%d.%d" $(expr ${BUILD_NUMBER} / 10) $(expr ${BUILD_NUMBER} % 10))
                            sudo -S docker tag my-docker-image:${VERSION} galvinaries/simplyfiday01:${VERSION}
                            sudo -S docker push galvinaries/simplyfiday01:${VERSION}
                        """
                    }
                }
            }
        }
    }
}
