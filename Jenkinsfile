pipeline {
    agent any
    
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
                    sh 'docker rm -f my-docker-container-${env.BUILD_NUMBER} || true'

                    // Run the new container
                    sh 'docker run -d -p 8081:80 --name my-docker-container-${env.BUILD_NUMBER} my-docker-image:${env.BUILD_NUMBER}'
                }
            }
        }
    }
    post {
        always {
            // Clean up any resources here
            script {
                sh 'docker rm -f my-docker-container-${env.BUILD_NUMBER} || true'
                docker.image("my-docker-image:${env.BUILD_NUMBER}").remove()
            }
        }
    }
}
