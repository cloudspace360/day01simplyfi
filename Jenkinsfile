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

                        sh '''
                            echo "y6d-p.7Z%5Uedxv" | docker login -u cloudspace320@gmail.com  --password-stdin
                            VERSION=$(printf "%d.%d" $(expr ${BUILD_NUMBER} / 10) $(expr ${BUILD_NUMBER} % 10))
                            docker build -t my-docker-image:${VERSION} .
                            docker tag my-docker-image:${VERSION} galvinaries/simplyfiday01:${VERSION}
                            docker push galvinaries/simplyfiday01:${VERSION}
                        '''
                    
                
                
            }
        }
         stage('Run Docker Container'){

            steps {
                script {
                    // Run the new container on client server
                    def exitCode = sh script: "ssh -o StrictHostKeyChecking=no -i /var/lib/jenkins/.ssh/id_rsa ${env.SSH_CREDENTIALS}@${env.CLIENT_SERVER} 'docker run -d -p 8085:80 --name my-docker-container-${env.BUILD_NUMBER} my-docker-image:${env.BUILD_NUMBER}'", returnStatus: true
                    if (exitCode == 0) {
                        env.CONTAINER_CREATED = true

                           }
                        }
                  }       


            }
    }
}
