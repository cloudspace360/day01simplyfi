pipeline {
    agent any
    
    environment {
        CONTAINER_CREATED = false
        CLIENT_SERVER = '54.87.24.137' // Replace 'your-client-server' with the hostname or IP address of your client server
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
    
        stage('Run Docker Container') {
            //Insatall docker container in remote
            steps {
                script {
                    sshScript remote: "${SSH_CREDENTIALS}@${env.CLIENT_SERVER}", label: 'Install Docker', script: """
                        sudo apt update
                        sudo apt install -y docker.io
                    """
                }
            }
            //Configure Docker Remote Access
            steps {
                script {
                    sshScript remote: "${SSH_CREDENTIALS}@${env.CLIENT_SERVER}", label: 'Configure Docker Remote Access', script: """
                        sudo usermod -aG docker ${params.REMOTE_USER}
                    """
                }
            }
            //pull docker image 
            steps {
                script {
                    sshScript remote: "${env.SSH_CREDENTIALS}@${env.CLIENT_SERVER}", label: 'Pull Docker Image', script: """
                        docker pull ${params.DOCKER_IMAGE}
                    """
                }
            }
            //Run docker container inm remote
            steps {
                
                    script{
                        def exitCode = sh script: "ssh -o StrictHostKeyChecking=no -i /var/lib/jenkins/.ssh/id_rsa ${env.SSH_CREDENTIALS}@${env.CLIENT_SERVER} 'docker run -d -p 8085:80 --name my-docker-container-${env.BUILD_NUMBER} my-docker-image:${env.BUILD_NUMBER}'", returnStatus: true
                        if (exitCode == 0) {
                        env.CONTAINER_CREATED = true

                           }
                    }


            }
        }

    

    }
}
