pipeline {
    agent any
    
    tools {
        maven 'mvn3.8.6'
    }
    
    triggers { pollSCM('*/1 * * * *') }

    stages {
        stage('Checkout'){
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[credentialsId: 'GitHub_token', url: 'https://github.com/vgtstl/simple-java-maven-app.git']]])
            }
        }
        stage('Version') {
            steps {
                sh "mvn --version"
            }
        }
        stage('Build') {
            steps {
                sh "mvn clean package"
            }
        }
        stage('DockerBuild'){
             steps {
                sh "docker  build -t helloworld ."
            } 
        }
    }
    post {
        always {
            junit 'target/surefire-reports/*.xml'
            archiveArtifacts artifacts: 'target/*.jar', followSymlinks: false
        }
        success {
            echo "Build Success"
            cleanWs()
        }
    }
}
