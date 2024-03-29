pipeline {
    agent any
    environment {
        registry = "670855725719.dkr.ecr.ap-south-1.amazonaws.com/testecr"
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
  
        // Building Docker images
        stage('Building image') {
            steps{
                script {
                    dockerImage = docker.build registry
                }
            }
        }
   
        // Uploading Docker images into AWS ECR
        stage('Pushing to ECR') {
            steps{  
                script {
                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'docker-ecr', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                        sh 'aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 670855725719.dkr.ecr.ap-south-1.amazonaws.com/testecr'
                        sh 'docker push 670855725719.dkr.ecr.ap-south-1.amazonaws.com/testecr'
                    }
                }
            }
        }

        // Deploying Docker container
        stage('Deploy Container') {
            steps {
                script {
                    docker.withRegistry('', 'docker-ecr') {
                        def customImage = docker.image(registry)
                        customImage.pull()
                        customImage.run("--name my-container -d -p 8090:8080") // Adjust as per your Docker container requirements
                    }
                }
            }
        }
    }
}
