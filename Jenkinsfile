pipeline {
    agent any

    environment {
        DOCKER_REGISTRY = "670855725719.dkr.ecr.ap-south-1.amazonaws.com/testecr"  // Replace with your ECR registry URI
        IMAGE_NAME = "my-docker-image"  // Replace with your Docker image name
        IMAGE_TAG = "latest"  // Replace with your desired image tag
    }

    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Maven Build') {
            steps {
                // Add Maven build step here
                sh 'mvn clean package' // Assuming Maven is installed and available in the PATH
            }
        }
    }
}
