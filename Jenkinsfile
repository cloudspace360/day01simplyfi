pipeline {
    agent any
    stages {
        stage('git_clone') {
            steps {
                deleteDir() // This step deletes the workspace
                git  url: 'https://github.com/cloudspace360/day01simplyfi.git',
                branch: 'main' ,
                credentialsId: "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"
            }
        }
        stage('Build and push image') {
            steps {
                sh '''
                    echo 'y6d-p.7Z%5Uedxv' | sudo -S docker login -u Galvinaries --password-stdin
                    VERSION=$(printf "%d.%d" $(expr ${BUILD_NUMBER} / 10) $(expr ${BUILD_NUMBER} % 10))
                    sudo -S docker build -t my-image:${VERSION} .
                    sudo -S docker tag my-image:${VERSION} galvinaries/simplyfiday01:${VERSION}
                    sudo -S docker push galvinaries/simplyfiday01:${VERSION}
                '''
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
