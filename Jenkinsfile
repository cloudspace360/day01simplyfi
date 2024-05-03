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
                    def port = findAvailablePort()
                    docker.image("my-docker-image:${env.BUILD_NUMBER}").run("-p ${port}:80", name: "my-docker-container-${env.BUILD_NUMBER}")
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

def findAvailablePort() {
    def socket = new java.net.ServerSocket(0)
    def port = socket.getLocalPort()
    socket.close()
    return port
}
