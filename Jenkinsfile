pipeline {
    agent any
    environment {
        registry = "670855725719.dkr.ecr.ap-south-1.amazonaws.com/testecr"
        MAVEN_HOME = tool 'maven' // Set up Maven tool
    }
   
    stages {
        stage('Cloning Git') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: '', url: 'https://github.com/akannan1087/myPythonDockerRepo']]])     
            }
        }
  
        // Maven Build stage
        stage('Maven Build') {
            steps {
                script {
                    def mavenHome = env.MAVEN_HOME
                    sh "${mavenHome}/bin/mvn clean package" // Adjust Maven command as per your project needs
                }
            }
        }

        // Building Docker images
        stage('Building image') {
            steps {
                script {
                    dockerImage = docker.build registry
                }
            }
        }
   
        // Uploading Docker images into AWS ECR
        stage('Pushing to ECR') {
            steps {  
                script {
                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'docker-acr', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                        sh 'aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 670855725719.dkr.ecr.ap-south-1.amazonaws.com/testecr'
                        sh 'docker push 670855725719.dkr.ecr.ap-south-1.amazonaws.com/testecr'
                    }
                }
            }
        }
    }
}
