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
            environment {
                MAVEN_HOME = tool 'maven' // 'Maven' refers to the name given to the Maven installation in Jenkins global tool configuration
            }
            steps {
                script {
                    def mavenHome = env.MAVEN_HOME
                    sh "${mavenHome}/bin/mvn clean package" // Adjust the command as per your requirements
                }
            }
        }

        stage('Docker Build and Push') {
            steps {
                script {
                    // Get ECR authorization token
                    def ecrLogin = sh(
                        script: "aws ecr get-login-password --region ap-south-1",
                        returnStdout: true
                    ).trim()

                    // Login to Docker registry
                    sh "docker login -u AWS -p ${ecrLogin} ${env.DOCKER_REGISTRY}"

                    // Define Docker image and Dockerfile
                    def dockerImage = "${env.DOCKER_REGISTRY}/${env.IMAGE_NAME}:${env.IMAGE_TAG}"
                    def dockerFile = "Dockerfile" // Update with your Dockerfile name and path if needed

                    // Build Docker image
                    sh "docker build -t ${dockerImage} -f ${dockerFile} ."

                    // Push Docker image to ECR
                    sh "docker push ${dockerImage}"
                }
            }
        }
    }
}
