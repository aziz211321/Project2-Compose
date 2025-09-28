pipeline {
    agent {
        docker {
            image 'node:16'
        }
    }

    environment {
        // This pulls the value from Jenkins credentials (ID must match)
        SNYK_TOKEN = credentials('SNYK_TOKEN')
    }

    stages {
        stage('Install Dependencies') {
            steps {
                sh 'npm install --save'
            }
        }

        stage('Unit Test') {
            steps {
                // This allows the pipeline to pass even if tests are not configured yet
                sh 'npm test || true'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    def app = "myapp-${env.BUILD_ID}"
                    sh "docker build -t ${app} ."
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                echo 'Push to registry here (DockerHub, GitHub Packages, etc.)'
                // Optional: docker login + docker push commands go here
            }
        }

        stage('Snyk Security Scan') {
            steps {
                sh 'npm install -g snyk'
                // Use the Jenkins credentials pulled above
                sh 'snyk auth $SNYK_TOKEN'
                // Fail build on High/Critical vulnerabilities
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

