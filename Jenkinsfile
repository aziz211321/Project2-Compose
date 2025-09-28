pipeline {
    agent {
        docker {
            image 'node:16'
        }
    }

    environment {
        DOCKER_IMAGE = 'abdulaziz2000/myapp:latest' // Change this to your DockerHub image name
        REGISTRY_CREDENTIALS = 'dockerhub-credentials' // You must add this in Jenkins > Credentials
    }

    stages {
        stage('Install Dependencies') {
            steps {
                sh 'npm install --save'
            }
        }

        stage('Run Unit Tests') {
            steps {
                sh 'npm test || exit 1'
            }
        }

        stage('Security Scan') {
            steps {
                sh 'npm install -g snyk'
                sh 'snyk auth $SNYK_TOKEN'  // You must add SNYK_TOKEN in Jenkins credentials
                sh 'snyk test --severity-threshold=high'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE .'
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: env.REGISTRY_CREDENTIALS,
                                                 usernameVariable: 'DOCKER_USER',
                                                 passwordVariable: 'DOCKER_PASS')]) {
                    sh """
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker push $DOCKER_IMAGE
                    """
                }
            }
        }
    }

    post {
        always {
            echo "Pipeline completed."
        }
        failure {
            echo "Pipeline failed."
        }
    }
}

