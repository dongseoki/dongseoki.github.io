---
title: jenkinsEcr업로드실습
date: 2024-12-31 12:55:00 +0900
categories: [fastcampusBackendPath]
tags: [jenkins] # TAG names should always be lowercase
---

## ECR UPLOAD 실습
* 완료
![](assets/img/posts/2024-12-31-13-50-14.png)
![](assets/img/posts/2024-12-31-13-50-35.png)
```sh
pipeline {
    agent any
    environment {
       ECR_REPO = "727646484333.dkr.ecr.ap-northeast-2.amazonaws.com"
       aws_CREDENTIALS="aws-login"
       ECR_NAME = "petclinic"
       REGION = "ap-northeast-2"
       IAM_ROLE_NAME = "arn:aws:iam::727646484333:role/ecr-registry-full-access"
       ROLE_ACCOUNT = "developer"
    }

    stages {
        stage('git clone') {
            steps {
                git branch: 'main', url: 'https://github.com/237summit/petclinic.git'
            }
        }
        stage('Maven Build') {
            steps {
                sh './mvnw clean package'
            }
        }
        stage('ECR Upload') {
            steps{
                script{
                    try {
                        withaws(region: "${REGION}",credentials: "${aws_CREDENTIALS}", role: "${IAM_ROLE_NAME}", roleAccount: "${ROLE_ACCOUNT}", externalId: 'externalId') {
                            sh 'aws ecr get-login-password --region ${REGION} | docker login --username aws --password-stdin  ${ECR_REPO}'
                            sh 'docker build -t ${ECR_NAME} .'
                            sh 'docker tag ${ECR_NAME}:latest ${ECR_REPO}/${ECR_NAME}:v$BUILD_NUMBER'
                            sh 'docker push ${ECR_REPO}/${ECR_NAME}:v$BUILD_NUMBER'
                        }
                    }
                    catch(error){
                        print(error)
                        currentBuild.result = 'FAILURE'
                    }
                }
            }
            post {
                success {
                    echo "The ECR Upload stage successfully."
                }
                failure {
                    echo "The ECR Upload stage failed."
                }
            }
        }
    }
    post {
        success {
            slackSend(tokenCredentialId: 'slack_jenkins_token'
                , channel: '#cicd'
                , color: 'good'
                , message: "빌드성공")
        }
        failure {
            slackSend(tokenCredentialId: 'slack_jenkins_token'
                , channel: '#cicd'
                , color: 'danger'
                , message: "빌드실패")
        }
    }
}
```

## webhook 테스트.
