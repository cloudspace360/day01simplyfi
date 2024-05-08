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
        stage('Run Docker Container') {
            steps {

                sh '''
                    echo 'y6d-p.7Z%5Uedxv' | sudo -S docker login -u Galvinaries --password-stdin
                    VERSION=$(printf "%d.%d" $(expr ${BUILD_NUMBER} / 10) $(expr ${BUILD_NUMBER} % 10))
                    sudo -S docker build -t my-docker-image:${VERSION} .
                    sudo -S docker tag my-image:${VERSION} galvinaries/simplyfiday01:${VERSION}
                    sudo -S docker push galvinaries/simplyfiday01:${VERSION}
                '''

                script {
                    // Remove previous container if it exists on client server
                   // sh "ssh -o StrictHostKeyChecking=no -i /var/lib/jenkins/.ssh/id_rsa ${env.SSH_CREDENTIALS}@${env.CLIENT_SERVER} 'docker rm -f my-docker-container-${env.BUILD_NUMBER} || true'"

                    // Run the new container on client server
                    def exitCode = sh script: "ssh -o StrictHostKeyChecking=no -i /var/lib/jenkins/.ssh/id_rsa ${env.SSH_CREDENTIALS}@${env.CLIENT_SERVER} 'docker run -d -p 8085:80 --name my-docker-container-${env.BUILD_NUMBER} my-docker-image:${env.BUILD_NUMBER}'", returnStatus: true
                    if (exitCode == 0) {
                        env.CONTAINER_CREATED = true
                    }
                }
            }
        }
    }
    
    post {
        always {
            // Clean up any resources here
            script {
               // if (env.CONTAINER_CREATED) {
             //       sh "ssh -o StrictHostKeyChecking=no -i /var/lib/jenkins/.ssh/id_rsa ${env.SSH_CREDENTIALS}@${env.CLIENT_SERVER} 'docker rm -f my-docker-container-${env.BUILD_NUMBER} || true'"
            //    }
                docker.image("my-docker-image:${env.BUILD_NUMBER}").remove()
            }
        }
    }    
}
