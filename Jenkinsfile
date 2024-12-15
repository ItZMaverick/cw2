pipeline {
    agent any
    environment {
        DOCKERHUB_CREDS = credentials('docker') // Use Jenkins stored credentials
    }
    stages {
        stage('Docker Image Build') {
            steps {
                script {
                    echo "Building Docker image..."
                    sh 'docker build -t 1uke04/cw2-server:latest .'
                }
            }
        }
        stage('Test Container') {
            steps {
                script {
                    echo "Testing container launch..."
                    sh '''
                    # Run container in detached mode
                    docker run --name test-container -d 1uke04/cw2-server:latest

                    # Check if container is running
                    if [ $(docker ps -q -f name=test-container | wc -l) -eq 0 ]; then
                        echo "Container failed to start!"
                        exit 1
                    fi

                    # Run a test command inside the container
                    docker exec test-container ls
                    docker logs test-container

                    # Clean up
                    docker rm -f test-container
                    '''
                }
            }
        }
        stage('Push to DockerHub') {
            steps {
                script {
                    echo "Pushing Docker image to DockerHub..."
                    sh '''
                    echo "$DOCKERHUB_CREDS_PSW" | docker login -u "$DOCKERHUB_CREDS_USR" --password-stdin
                    docker push 1uke04/cw2-server:latest
                    '''
                }
            }
        }
    }
}