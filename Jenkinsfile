pipeline {
    agent any

    tools {
        maven "mvn3.8.6"
    }
    
    triggers { pollSCM('*/1 * * * *') }

    stages {
        stage('Version') {
            steps {
                sh "mvn --version"
            }
        }
        stage('Build') {
            steps {
                sh "mvn -Dmaven.test.failure.ignore=true clean package"
            }
        }
    }
    post {
        always {
            archiveArtifacts artifacts: 'target/*.jar', followSymlinks: false
        }
    }
}
