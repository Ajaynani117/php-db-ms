pipeline{
    agent none
    environment{
        DEV_SERVER='ec2-user@100.26.112.11'
        IMAGE_NAME='ajaynani117/test:php$BUILD_NUMBER'
        TEST_SERVER='ec2-user@54.234.57.195'
    }

    stages{
        //terraform //ansible
        stage('BUILD PHP DOCKERIMAGE AND PUSH TO DOCKERHUB'){
            agent any
            steps{
                script{
                sshagent(['DEV_SERVER']) {
                withCredentials([usernamePassword(credentialsId: 'docker-hub', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
                echo "Building the php image"
                sh "scp -o StrictHostKeyChecking=no -r BuildConfig ${DEV_SERVER}:/home/ec2-user"
                sh "ssh -o StrictHostKeyChecking=no ${DEV_SERVER} 'bash ~/BuildConfig/docker-script.sh'"
                sh "ssh ${DEV_SERVER} sudo docker build -t ${IMAGE_NAME} /home/ec2-user/BuildConfig/"
                sh "ssh ${DEV_SERVER} sudo docker login -u $USERNAME -p $PASSWORD"
                sh "ssh ${DEV_SERVER} sudo docker push ${IMAGE_NAME}"
                }
            }
        }
    }
}
stage('RUN PHP_DB with Dockercompose'){
            agent any
            steps{
                script{
                sshagent(['TEST_SERVER']) {
                withCredentials([usernamePassword(credentialsId: 'docker-hub', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
                echo "Deploy PHP and Sql containers"
                sh "scp -o StrictHostKeyChecking=no -r deployConfig ${TEST_SERVER}:/home/ec2-user"
                sh "ssh -o StrictHostKeyChecking=no ${TEST_SERVER} 'bash ~/deployConfig/docker-script.sh'"
                sh "ssh ${TEST_SERVER} sudo docker login -u $USERNAME -p $PASSWORD"
                sh "ssh ${TEST_SERVER} bash /home/ec2-user/deployConfig/docker-compose-script.sh ${IMAGE_NAME}"
                }
            }
        }
    }
}
    }
}
