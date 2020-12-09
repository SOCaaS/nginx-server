pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                sh 'echo ${BUILD_NUMBER}'
                sh 'docker build -f dockerfile --tag nginx-server:${BUILD_NUMBER} .'
           }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
                sh 'docker run --name test-nginx --network main-overlay nginx-server:${BUILD_NUMBER} nginx -t'
                sh 'docker rm test-nginx'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
                sh 'TAG=${BUILD_NUMBER} docker stack deploy --compose-file docker-stack.yml nginx-proxy'
            }
        }
    }
    post {
        success {
            discordSend description: "Jenkins Pipeline Build Success", footer: "Nginx Server", link: env.BUILD_URL, result: currentBuild.currentResult, title: JOB_NAME, webhookURL: env.SOCAAS-WEBHOOK
        }
        failure {
            discordSend description: "Jenkins Pipeline Build Failed", footer: "Nginx Server", link: env.BUILD_URL, result: currentBuild.currentResult, title: JOB_NAME, webhookURL: env.SOCAAS-WEBHOOK
        }
    }
}
