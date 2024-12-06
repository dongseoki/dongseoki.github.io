---
title: 패캠_백엔드_패스_Course8_Chap3_docker ECR부터 실습
date: 2024-12-06 08:20:00 +0900
categories: [fastcampusBackendPath]
tags: [docker] # TAG names should always be lowercase
---

## 실습 가즈아
* create REpo
![](assets/img/posts/2024-12-06-09-01-25.png)
aws ecr get-login-password --region region | docker login --username AWS --password-stdin aws_account_id.dkr.ecr.region.amazonaws.com


aws ecr get-login-password --region ap-northeast-2 | docker login --username AWS --password-stdin 727646484333.dkr.ecr.ap-northeast-2.amazonaws.com

docker tag webapp:v1 727646484333.dkr.ecr.ap-northeast-2.amazonaws.com/dslee/myrepo:v1


docker push 727646484333.dkr.ecr.ap-northeast-2.amazonaws.com/dslee/myrepo:v1

docker run -d --name webapp_ecr 727646484333.dkr.ecr.ap-northeast-2.amazonaws.com/dslee/myrepo:v1

## 참고
https://docs.aws.amazon.com/AmazonECR/latest/userguide/docker-push-ecr-image.html
https://docs.aws.amazon.com/AmazonECR/latest/userguide/repository-create.html
https://velog.io/@msung99/Docker-%EC%9D%B4%EB%AF%B8%EC%A7%80-%EB%B9%8C%EB%93%9C-%ED%94%8C%EB%9E%AB%ED%8F%BC-%ED%98%B8%ED%99%98%EC%84%B1-%EA%B4%80%EB%A0%A8-%EC%97%90%EB%9F%AC-linuxamd64
