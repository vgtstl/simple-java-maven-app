pipeline {
    agent {
        docker {
            image 'maven:3.8.6-openjdk-18'
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
