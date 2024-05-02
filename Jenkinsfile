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
                    // Remove the old container if it exists
                    docker.image('my-python-app').remove(force: true)
                    
                    // Run the new container
                    docker.image('my-python-app').run('-p 8082:8080')  // Replace 'my-python-app' with the image name you built
                }
            }
        }
    }
}
