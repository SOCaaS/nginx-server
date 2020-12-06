pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                sh 'echo ${BUILD_NUMBER}'
                sh 'docker build -f dockerfile --tag nginx-server:${BUILD_NUMBER} .'
                sh 'echo TAG=${BUILD_NUMBER} >> .env'
           }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
                sh 'docker run --name test-nginx nginx-server:${BUILD_NUMBER} nginx -t'
                sh 'docker stop test-nginx && docker rm test-nginx'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
                sh 'docker stack deploy --compose-file docker-stack.yml nginx-proxy'
            }
        }
    }
    post {
        success {
            discordSend description: "Jenkins Pipeline Build Success", footer: "Nginx Server", link: env.BUILD_URL, result: currentBuild.currentResult, title: JOB_NAME, webhookURL: "https://discord.com/api/webhooks/784998511519334500/Ys5GLuUn3uWM9N-_xuV_BQZnnNNWqqHIKkTVOoT7zY-7UTo64DqRmyhszW2Beq8hIhFY"
        }
        failure {
            discordSend description: "Jenkins Pipeline Build Failed", footer: "Nginx Server", link: env.BUILD_URL, result: currentBuild.currentResult, title: JOB_NAME, webhookURL: "https://discord.com/api/webhooks/784998511519334500/Ys5GLuUn3uWM9N-_xuV_BQZnnNNWqqHIKkTVOoT7zY-7UTo64DqRmyhszW2Beq8hIhFY"
        }
    }
}
