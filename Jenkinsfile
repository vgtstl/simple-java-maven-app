pipeline {
    agent {
        docker {
            image 'maven:3.5.4-jdk-7-alpine'
        }
    }
    
    //triggers { pollSCM('*/1 * * * *') }

    stages {
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
