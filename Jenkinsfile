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
                    // Find an available port dynamically
                    def port = findAvailablePort()
                    docker.image("my-docker-image:${env.BUILD_NUMBER}").run("-p ${port}:80")
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
