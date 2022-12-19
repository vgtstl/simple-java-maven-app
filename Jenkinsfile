pipeline {
    agent any

    tools {
        maven 'mvn3.8.6'
    }

    options {
        timeout(time: 10, unit: 'MINUTES')
        timestamps()
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
                sh 'mvn --version'
            }
        }
        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
            post {
                always {
                    junit 'target/surefire-reports/*.xml'
                    archiveArtifacts artifacts: 'target/*.jar', followSymlinks: false
                }
            }
        }
        stage('DockerBuild'){
            steps {
                sh 'docker build -t venu/helloworld .'
            }
        }
        stage('DockerScan'){
            steps {
                echo 'docker scan venu/helloworld'
            }
        }
        stage('DockePush'){
            when {
                branch 'master'
            }
            steps {
                echo 'docker  push venu/helloworld'
            }
        }
        stage('Deploy to Dev'){
            when {
                branch 'master'
            }
            steps {
                echo 'Dev Deployment Completed'
            }
        }
        stage('Deploy to QA'){
            when {
                branch 'master'
            }
            steps {
                echo 'QA Deployment Completed'
            }
        }
        stage('Deploy to Prod'){
            when {
                branch 'master'
            }
            steps {
                input('Do you wants to proceed with prod deployment')
                echo 'Prod Deployment Completed'
            }
        }
    }
    post {
        success {
            echo 'Build Success'
            cleanWs()
        }
    }
}
