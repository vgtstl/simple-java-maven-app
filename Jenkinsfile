pipeline {
    agent {
        docker {
            image 'maven:3.5.4-jdk-7-alpine'
            args '-v /root/.m2:/root/.m2'
        }
    }
    
    //triggers { pollSCM('*/1 * * * *') }

    stages {
        stage('Checkout'){
            checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[credentialsId: 'GitHub_token', url: 'https://github.com/vgtstl/simple-java-maven-app.git']]])
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
