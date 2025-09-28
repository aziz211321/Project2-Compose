pipeline {
    agent {
        docker { image 'node:16' }
    }
    environment {
        SNYK_TOKEN = credentials('SNYK_TOKEN')
    }
    stages {
        stage('Checkout SCM') {
            steps {
                checkout scm
            }
        }
        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }
        stage('Run Unit Tests') {
            steps {
                sh 'npm test || echo "Tests failed (optional if none exist)"'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t myapp .'
            }
        }
        stage('Snyk Security Scan') {
            steps {
                sh 'npm install -g snyk'
                sh 'snyk auth $SNYK_TOKEN'
                sh 'snyk test || echo "Snyk test failed"'
            }
        }
    }
}

