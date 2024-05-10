pipeline {
    agent any
    
    environment {
        CONTAINER_CREATED = false
        CLIENT_SERVER = '35.153.159.245' // Replace 'your-client-server' with the hostname or IP address of your client server
        SSH_CREDENTIALS = 'ubuntu' // Replace 'your-ssh-credentials' with the name of your SSH credentials configured in Jenkins
        VERSION = sh(script: 'printf "%d.%d" $(expr ${BUILD_NUMBER} / 10) $(expr ${BUILD_NUMBER} % 10)', returnStdout: true).trim()
    }
    
    stages {
        stage('Build and Push Docker Image') {
            steps {
                script {
                    sh '''
                        echo "y6d-p.7Z%5Uedxv" | docker login -u cloudspace320@gmail.com  --password-stdin
                        docker build -t my-docker-image:${VERSION} .
                        docker tag my-docker-image:${VERSION} galvinaries/simplyfiday01:${VERSION}
                        docker push galvinaries/simplyfiday01:${VERSION}
                    '''
                }
            }
        }
    
        stage('Run Docker Container') {
            steps {
                script {
                    // SSH into the remote server and execute Docker commands
                    sh '''
                        ssh -i /var/lib/jenkins/.ssh/id_rsa ${SSH_CREDENTIALS}@${env.CLIENT_SERVER}
                        echo "connected sucessfully to the remote"
                        sudo apt update
                        sudo apt install -y docker.io
                        sudo usermod -aG docker jenkins
                        docker pull galvinaries/simplyfiday01:${VERSION}
                        docker run -d -p 8085:80 --name my-docker-container-${BUILD_NUMBER} galvinaries/simplyfiday01:${VERSION}
                    
                    '''
                    
                    // Check if Docker container is created successfully
                    def exitCode = sh(script: 'ssh -i /var/lib/jenkins/.ssh/id_rsa ${SSH_CREDENTIALS}@${env.CLIENT_SERVER} docker ps -q --filter "name=my-docker-container-${BUILD_NUMBER}"', returnStatus: true)
                    
                    if (exitCode == 0) {
                        env.CONTAINER_CREATED = true
                    }
                }
            }
        }
    }
}
