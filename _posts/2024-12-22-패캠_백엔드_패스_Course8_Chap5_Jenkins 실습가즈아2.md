---
title: 패캠_백엔드_패스_Course8_Chap5_Jenkins 실습가즈아2
date: 2024-12-22 14:55:00 +0900
categories: [fastcampusBackendPath]
tags: [jenkins] # TAG names should always be lowercase
---

## 필기 가자
* 일단 실습 강의를 참고하여 jenkins Dockerfile을 다시 만들어보았다.
```sh
FROM jenkins/jenkins:2.431-jdk17

USER root

# docker in docker install

RUN apt-get update && \
    apt-get -y install apt-transport-https \
      ca-certificates \
      curl \
      gnupg2 \
      jq \
      software-properties-common && \
    curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg > /tmp/dkey; apt-key add /tmp/dkey && \
    add-apt-repository \
      "deb [arch=arm64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
      $(lsb_release -cs) \
      stable" && \
   apt-get update && \
   apt-get -y install docker-ce

RUN groupadd -f docker
RUN usermod -aG docker jenkins

#aws cli install
# RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install

LABEL maintainer="dongseok.lee.log@gmail.com"
ENV JENKINS_USER admin
ENV JENKINS_PASS admin
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=true
RUN jenkins-plugin-cli \
    --plugins \
    git \
    workflow-aggregator \
    blueocean \
    docker-plugin \
    docker-workflow \
    ant \
    gradle \
    pipeline-aws \
    pipeline-build-step \
    pipeline-github-lib \
    pipeline-rest-api \
    pipeline-stage-view \
    timestamper \
    aws-credentials \
    file-operations \
    branch-api \
    workflow-support \
    pam-auth \
    ldap \
    email-ext \
    matrix-auth \
    ws-cleanup \
    resource-disposer \
    antisamy-markup-formatter \
    build-timeout \
    nodejs \
    slack:664.vc9a_90f8b_c24a_
```

* aws cli 부분, 젠킨스 버전이 수정되었다.

## 그리고 이제 해야할것.

```sh
docker run --name jenkins2 -d \
    -v ~/.docker/run/docker.sock:/var/run/docker.sock \
    -p 8090:8080 jenkins-ci:v2
```
로 만들고 docker inspect로 반드시 확인하기.
* 간단히 만든 docker item test 도 참고하자.

## slack noti의 시도.
* 슬렉 노트도 아래 작업물들을 참고하여 작업을 하였는데 실패했다.
https://blog.greatpark.co.kr/90
* 그리고 강의안 결과.
![](assets/img/posts/2024-12-22-15-36-31.png)
* 아무튼 이런 에러가 떴다.



## 나의 실수?
* 주의 집중이 산만해 졌다.
  * 귀마개를 끼던 집중 의식을 하던 했어야했는데, 떨어진상태로 작업.
  * 휴식을 취해야할때 알기.
* 어수선한 창 개수
  * 점점 어수선해 졌다. 브라우저 탭개수를 적절히 조절해가자. 내 생각 로직이 살짝 복잡해지거나, 정리해야지 싶을때는 노션이나 이 글이나 수첩에 글쓰기를 활용하자.
  * 나는 분명 이 실습을 잘 해낼 수 있을 것이다.
