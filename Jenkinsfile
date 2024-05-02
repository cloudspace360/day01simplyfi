pipeline {
    agent any
    
    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build('my-docker-image')  // Replace 'my-docker-image' with your desired image name
                }
            }
        }
        
        stage('Run Docker Container') {
            steps {
                script {
                    docker.run('my-docker-image')  // Replace 'my-docker-image' with the image name you built
                }
            }
        }
    }
}
