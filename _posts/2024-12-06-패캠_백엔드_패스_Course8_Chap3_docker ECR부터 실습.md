---
title: 패캠_백엔드_패스_Course8_Chap3_docker ECR부터 실습
date: 2024-12-06 08:20:00 +0900
categories: [fastcampusBackendPath]
tags: [docker] # TAG names should always be lowercase
---

## 실습 가즈아
* create REpo
![](assets/img/posts/2024-12-06-09-01-25.png)
```sh
aws ecr get-login-password --region region | docker login --username aws --password-stdin aws_account_id.dkr.ecr.region.amazonaws.com


aws ecr get-login-password --region ap-northeast-2 | docker login --username aws --password-stdin 727646484333.dkr.ecr.ap-northeast-2.amazonaws.com

docker tag webapp:v1 727646484333.dkr.ecr.ap-northeast-2.amazonaws.com/dslee/myrepo:v1


docker push 727646484333.dkr.ecr.ap-northeast-2.amazonaws.com/dslee/myrepo:v1

docker run -d --name webapp_ecr 727646484333.dkr.ecr.ap-northeast-2.amazonaws.com/dslee/myrepo:v1

docker build -t webapp:v1  .


docker buildx build --platform linux/amd64,linux/arm64 -t webapp:v2  .

docker tag webapp:v2 727646484333.dkr.ecr.ap-northeast-2.amazonaws.com/dslee/myrepo:v2
```

## 참고
https://docs.aws.amazon.com/AmazonECR/latest/userguide/docker-push-ecr-image.html
https://docs.aws.amazon.com/AmazonECR/latest/userguide/repository-create.html
https://velog.io/@msung99/Docker-%EC%9D%B4%EB%AF%B8%EC%A7%80-%EB%B9%8C%EB%93%9C-%ED%94%8C%EB%9E%AB%ED%8F%BC-%ED%98%B8%ED%99%98%EC%84%B1-%EA%B4%80%EB%A0%A8-%EC%97%90%EB%9F%AC-linuxamd64


### 현장 중심 컨테이너 실습
#### 2.2 컨테이너 경량으로 만들기
#### 패키지 설치시
  * -qq 옵션은 quiet 옵션의 2단계로 로깅 정보를 삭제
  * --no-install-recommends 옵션을 통해 apt가 자동으로 권장 패키지를 설치하지 않게 하여 꼭 필요한 패키지만 설치
### 패키지 설치 완료되면,
  *  apt 패키지 설치 시 사용했던 apt 캐시를 모두 삭제한다.
cat > Dockerfile.lightweight << EOF
FROM ubuntu:18.04
LABEL maintainer="SEONGMI-LEE <seongmi.lee@gmail.com>"
RUN apt update && \
    apt install apache2 -y -qq --no-install-recommends && \
    apt clean -y && \
    apt autoremove -y &&\
    rm -rfv /var/lib/apt/lists/* /tmp/* /var/tmp/*
COPY index.html /var/www/html/index.html
CMD apachectl -DFOREGROUND
EOF


### Multi-Stage Dockerfile
cat > Dockerfile.multi << EOF
### First Stage
FROM golang:1.13-alpine as builder
WORKDIR /usr/src/app
COPY main.go .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -ldflags '-s' -o main .

#Final Stage
FROM scratch
COPY --from=builder /usr/src/app/main /main
CMD [ "/main" ]
EOF

docker build -t hello-multi . -f Dockerfile.multi
