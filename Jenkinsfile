pipeline {
    agent any
    
    environment {
        CONTAINER_CREATED = false
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
                    // Remove previous container if it exists
                    sh "docker rm -f my-docker-container-${env.BUILD_NUMBER} || true"

                    // Run the new container
                    def exitCode = sh script: "docker run -d -p 8081:80 --name my-docker-container-${env.BUILD_NUMBER} my-docker-image:${env.BUILD_NUMBER}", returnStatus: true
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
                if (env.CONTAINER_CREATED) {
                   // sh "docker rm -f my-docker-container-${env.BUILD_NUMBER} || true"
                }
                docker.image("my-docker-image:${env.BUILD_NUMBER}").remove()
            }
        }
    }    
}

