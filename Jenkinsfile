pipeline {
    agent any
    
    environment {
        CONTAINER_CREATED = false
        CLIENT_SERVER = '34.230.85.141' // Replace 'your-client-server' with the hostname or IP address of your client server
        SSH_CREDENTIALS = 'ubuntu' // Replace 'your-ssh-credentials' with the name of your SSH credentials configured in Jenkins
    }
    
    stages {
        
//        stage('Build Docker Image') {
  //          steps {
    //            script {
      //              docker.build("my-docker-image:${env.BUILD_NUMBER}")
        //        }
          //  }
        //}
    
        stage('Build and Push Docker Image') {

            steps {
                script {
                    withCredentials([string(credentialsId: 'cloudspace320@gmail.com', variable: 'dockerhubpwd')]) {
                        sh '''
                            VERSION=$(printf "%d.%d" $(expr ${BUILD_NUMBER} / 10) $(expr ${BUILD_NUMBER} % 10))
                            docker build -t my-docker-image:${VERSION} .
                            docker tag my-docker-image:${VERSION} galvinaries/simplyfiday01:${VERSION}
                            docker push galvinaries/simplyfiday01:${VERSION}
                        '''
                    }
                }
            }
        }
    }
}
