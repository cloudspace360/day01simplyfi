pipeline {
    agent any
    
    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build('my-python-app')  // Replace 'my-python-app' with your desired image name
                }
            }
        }
        
        stage('Run Docker Container') {
            steps {
                script {
                    // Stop and remove the old container if it exists
                    sh 'docker stop my-python-container || true'
                    sh 'docker rm my-python-container || true'
                    
                    // Run the new container
                    docker.image('my-python-app').run('-p 8082:8080 --name my-python-container')  // Replace 'my-python-app' with the image name you built
                }
            }
        }

        stage('Delete image') {
            steps {
               script {
                    // Delete Docker image if it exists
                    def imageTag = env.BUILD_NUMBER
                    def imageName = "my-image:${imageTag}"
 
                    // Check if the image exists
                    def imageExists = sh(script: "docker images -q ${imageName}", returnStatus: true) == 0
 
                    if (imageExists) {
                        sh "docker rmi -f ${imageName}"
                    } else {
                        echo "Image ${imageName} does not exist."
                    }
                }
            }
    }
}
}
        
