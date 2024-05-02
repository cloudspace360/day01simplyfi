pipeline {
    agent {
        dockerfile {
            filename 'Dockerfile'
            label 'my-docker-agent'
            args '-v /var/run/docker.sock:/var/run/docker.sock'
        }
    }
    stages {
        stage('Build') {
            steps {
                sh 'echo "Building..."'
            }
        }
        stage('Test') {
            steps {
                sh 'echo "Testing..."'
            }
        }
        stage('Deploy') {
            steps {
                sh 'echo "Deploying..."'
            }
        }
    }
}
