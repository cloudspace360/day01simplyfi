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
                    docker.image('my-python-app').run('-p 8080:8080')  // Replace 'my-python-app' with the image name you built
                }
            }
        }
    }
}
