pipeline {
    agent any
    
    environment {
        CONTAINER_CREATED = false
        CLIENT_SERVER = '3.85.240.202' // Replace 'your-client-server' with the hostname or IP address of your client server
        SSH_CREDENTIALS = 'client-ssh-credentials' // Replace 'your-ssh-credentials' with the name of your SSH credentials configured in Jenkins
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
                script {
                    // Remove previous container if it exists on client server
                   // sh "ssh -o StrictHostKeyChecking=no -i /var/lib/jenkins/.ssh/id_rsa ${env.SSH_CREDENTIALS}@${env.CLIENT_SERVER} 'docker rm -f my-docker-container-${env.BUILD_NUMBER} || true'"

                    // Run the new container on client server
                    def exitCode = sh script: "ssh -o StrictHostKeyChecking=no -i /var/lib/jenkins/.ssh/id_rsa ${env.SSH_CREDENTIALS}@${env.CLIENT_SERVER} 'docker run -d -p 8081:80 --name my-docker-container-${env.BUILD_NUMBER} my-docker-image:${env.BUILD_NUMBER}'", returnStatus: true
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
