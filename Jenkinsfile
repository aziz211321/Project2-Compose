pipeline {
    agent {
        docker {
            image 'node:16'
        }
    }

    environment {
        SNYK_TOKEN = credentials('3e62befd-0cde-4768-b2c7-c92c2e17274e') 
    }

    stages {
        stage('Install Dependencies') {
            steps {
                sh 'npm install --save'
            }
        }

        stage('Unit Test') {
            steps {
                sh 'npm test || true' // Use '|| true' only if your app doesn't have test configured yet
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    def app = "myapp-${env.BUILD_ID}"
                    sh "docker build -t $app ."
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                // Optional: Only if you setup DockerHub credentials
                echo 'Push to registry here (DockerHub, GitHub Packages, etc.)'
            }
        }

        stage('Snyk Security Scan') {
            steps {
                sh 'npm install -g snyk'
                sh 'snyk auth $SNYK_TOKEN'
                sh 'snyk test --severity-threshold=high'
            }
        }
    }

    post {
        failure {
            echo 'Build failed!'
        }
    }
}

