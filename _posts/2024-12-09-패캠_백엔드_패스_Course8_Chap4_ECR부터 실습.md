---
title: 패캠_백엔드_패스_Course8_Chap4_ECR부터 실습
date: 2024-12-09 08:20:00 +0900
categories: [fastcampusBackendPath]
tags: [ECR, ECS, AWS] # TAG names should always be lowercase
---

## 실습 가즈아
* ECR
* ECS
2-3. Service
ECS의 Service는 Task의 수명주기를 지속적으로 관리하는 상위 그룹 단위입니다.

ECS Service의 역할은 다음과 같습니다.

Cluster에 배포할 Task 수 결정
Task의 배포 방식 결정 (롤링 or Blue/Green)
AutoScale 설정 등 ELB와 관련한 작업

![](assets/img/posts/2024-12-09-12-56-59.png)

![](assets/img/posts/2024-12-09-12-57-09.png)

컨테이너에서 실행할 수 있도록 애플리케이션을 설계해야 합니다. 컨테이너는 소프트웨어 애플리케이션을 실행하는 데 필요한 모든 것을 포함하는 소프트웨어 개발의 표준화된 단위입니다. 여기에는 관련 코드, 런타임, 시스템 도구 및 시스템 라이브러리가 포함됩니다. 컨테이너는 이미지라고 하는 읽기 전용 템플릿에서 생성됩니다. 이미지는 일반적으로 Dockerfile에서 구축됩니다. Dockerfile은 컨테이너 빌드 지침을 포함하는 일반 텍스트 파일입니다. 이러한 이미지는 빌드된 후 다운로드할 수 있는 Amazon ECR과 같은 레지스트리에 저장됩니다.

이미지를 생성하고 저장한 후 Amazon ECS 작업 정의를 생성합니다. 작업 정의는 애플리케이션에 대한 청사진과 같습니다. 작업 정의는 애플리케이션을 구성하는 파라미터 및 하나 이상의 컨테이너를 설명하는 JSON 형식의 텍스트 파일입니다. 예를 들어, 이를 사용하여 운영 체제에 대한 이미지 및 파라미터, 사용할 컨테이너, 애플리케이션에 대해 개방할 포트, 작업의 컨테이너와 함께 사용할 데이터 볼륨을 지정할 수 있습니다. 태스크 정의에 사용할 수 있는 특정 파라미터는 특정 애플리케이션의 필요에 따라 달라집니다.

작업 정의를 정의한 후에는 클러스터에 서비스 또는 작업으로 배포합니다. 클러스터는 클러스터에 등록된 용량 인프라에서 실행되는 작업 또는 서비스의 논리적 그룹입니다.

태스크는 클러스터 내 태스크 정의를 인스턴스화하는 것입니다. 독립 실행형 태스크를 실행하거나 서비스의 일부로 태스크를 실행할 수 있습니다. Amazon ECS 서비스를 사용하여 Amazon ECS 클러스터에서 원하는 수의 태스크를 동시에 실행하고 유지할 수 있습니다. 태스크가 어떤 이유로든 실패하거나 중지하면 Amazon ECS 서비스 스케줄러가 태스크 정의에 따라 다른 인스턴스를 시작하는 방식으로 작동합니다. 이로써 이를 대체하여 서비스에서 원하는 수의 태스크를 유지할 수 있습니다.

컨테이너 에이전트는 Amazon ECS 클러스터 내의 각 컨테이너 인스턴스에서 실행됩니다. 에이전트는 현재 실행 중인 태스크와 컨테이너의 리소스 사용률에 대한 정보를 Amazon ECS로 전송합니다. Amazon ECS로부터 요청을 수신할 때마다 태스크를 시작 및 중지합니다.

작업 또는 서비스를 배포한 후 다음 도구 중 하나를 사용하여 배포 및 애플리케이션을 모니터링할 수 있습니다.

CloudWatch

Runtime Monitoring


## ECR ec2 활용 실습
* 일단 ecs role 부터 생성했었음.

* 그리고 클러스터 생성을 테스트했었음.
![](assets/img/posts/2024-12-10-21-09-13.png)

* CloudFormation에서 리소스들이 생성되는 이벤트를 확인 가능.
![](assets/img/posts/2024-12-10-21-11-01.png)

* 12분 45초 까지 테스트 완료함.

* IAM 역할 생성후, task Definition 등록이 이어짐.
* 다음 ECS의 service 생성.
* ALB Target group 생성. ECS 메뉴 가서 생성.nginx-alb-tg
* 그다음 ALB 생성. ECS 메뉴 가서 생성. nginx-alb
 * ALB 옵션중 Application Load Balancer 선택.
![](assets/img/posts/2024-12-11-21-09-46.png)
* 낭패다. 적어도 2가지 subnet을 써야한다고 하는데, 강사님의 개발 환경과 다른 듯하다.
* 이 부분을 반드시 추후 체크하자.
* 그리고 강사님은 alb 링크로 접속하여 nginx 잘 됨을 확인하였다. 이상!
## ECR Fargate 실습.
* ECS : EC2 인스턴스 안에 배포
* Fargate : 서버리스 컨테이너 배포

## 리소스 삭제 실습.

## 참고

https://docs.aws.amazon.com/ko_kr/AmazonECS/latest/developerguide/Welcome.html
https://ksh-coding.tistory.com/134#1.%20AWS%20ECS%EB%9E%80%3F-1
