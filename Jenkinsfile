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
                    docker.image("my-docker-image:${env.BUILD_NUMBER}").run('-p 8081:80')
                }
            }
        }
        stage('Deploy') {
            steps {
                // Add deployment steps here if needed
            }
        }
    }
    post {
        always {
            // Clean up any resources here
            script {
                docker.image("my-docker-image:${env.BUILD_NUMBER}").remove()
            }
        }
    }
}
