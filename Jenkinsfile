pipeline {
    agent any
    
    
    //triggers { pollSCM('*/1 * * * *') }

    stages {
        stage('Checkout'){
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[credentialsId: 'GitHub_token', url: 'https://github.com/vgtstl/simple-java-maven-app.git']]])
            }
        }
        stage('Version') {
            agent {
                docker {
                    image 'maven:3.5-jdk-8'
                    args '-v /root/.m2:/root/.m2'
                }
            }
            steps {
                sh "mvn --version"
            }
        }
        stage('Build') {
            agent {
                docker {
                    image 'maven:3.5-jdk-8'
                    args '-v /root/.m2:/root/.m2'
                }
            }
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
