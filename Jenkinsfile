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
                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'docker-ecr', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                        sh 'aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 670855725719.dkr.ecr.ap-south-1.amazonaws.com/testecr'
                        sh 'docker push 670855725719.dkr.ecr.ap-south-1.amazonaws.com/testecr'
                }
            }
        }
    }
}

