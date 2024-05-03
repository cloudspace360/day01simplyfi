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
                    def previousContainer = docker.container("my-docker-container-${env.BUILD_NUMBER}")
                    if (previousContainer) {
                        previousContainer.stop()
                        previousContainer.remove(force: true)
                    }

                    // Run the new container
                    docker.image("my-docker-image:${env.BUILD_NUMBER}").run("-p 8081:80", name: "my-docker-container-${env.BUILD_NUMBER}")
                }
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
