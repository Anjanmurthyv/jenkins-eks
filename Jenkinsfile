pipeline {
    agent any

    environment {
        DOCKER_REGISTRY = "123456789012.dkr.ecr.us-west-2.amazonaws.com"  // Replace with your ECR registry URI
        IMAGE_NAME = "my-docker-image"  // Replace with your Docker image name
        IMAGE_TAG = "latest"  // Replace with your desired image tag
    }

    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                bat "mvn clean install -Dmaven.test.skip=true"
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${DOCKER_REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG}", '.')
                }
            }
        }

        stage('Push to ECR') {
            steps {
                script {
                    docker.withRegistry("${DOCKER_REGISTRY}", "ecr:us-west-2") {
                        docker.image("${DOCKER_REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG}").push()
                    }
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    docker.image("${DOCKER_REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG}").run("-p 8080:8080")
                }
            }
        }
    }
}
