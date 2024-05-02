pipeline {
    agent any
    
    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build('ubuntu:22.04')  // Replace 'my-python-app' with your desired image name
                }
            }
        }
        
        stage('Run Docker Container') {
            steps {
                script {
                    
                    // Run the new container
                    docker.image('ubuntu:22.04').run('-p 8082:8080 --name ubuntu1')  // Replace 'my-python-app' with the image name you built
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
        
