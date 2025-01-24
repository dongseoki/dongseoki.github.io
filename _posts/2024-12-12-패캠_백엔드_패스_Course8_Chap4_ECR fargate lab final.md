---
title: 패캠_백엔드_패스_Course8_Chap4_ECR fargate lab final
date: 2024-12-12 08:30:00 +0900
categories: [fastcampusBackendPath]
tags: [ECR, ECS, aws, Fargate] # TAG names should always be lowercase
---

## final lab 실습 가즈아
![](assets/img/posts/2024-12-12-08-30-52.png)
![](assets/img/posts/2024-12-12-08-31-06.png)

```sh
aws ec2 create-vpc --cidr-block "10.0.0.0/16" --instance-tenancy "default" --tag-specifications '{"resourceType":"vpc","tags":[{"key":"Name","value":"ecs-prac-vpc"}]}'
aws ec2 modify-vpc-attribute --vpc-id "preview-vpc-1234" --enable-dns-hostnames '{"value":true}'
aws ec2 describe-vpcs --vpc-ids "preview-vpc-1234"
aws ec2 create-subnet --vpc-id "preview-vpc-1234" --cidr-block "10.0.0.0/20" --availability-zone "ap-northeast-2a" --tag-specifications '{"resourceType":"subnet","tags":[{"key":"Name","value":"ecs-prac-subnet-public1-ap-northeast-2a"}]}'
aws ec2 create-subnet --vpc-id "preview-vpc-1234" --cidr-block "10.0.16.0/20" --availability-zone "ap-northeast-2b" --tag-specifications '{"resourceType":"subnet","tags":[{"key":"Name","value":"ecs-prac-subnet-public2-ap-northeast-2b"}]}'
aws ec2 create-subnet --vpc-id "preview-vpc-1234" --cidr-block "10.0.128.0/20" --availability-zone "ap-northeast-2a" --tag-specifications '{"resourceType":"subnet","tags":[{"key":"Name","value":"ecs-prac-subnet-private1-ap-northeast-2a"}]}'
aws ec2 create-subnet --vpc-id "preview-vpc-1234" --cidr-block "10.0.144.0/20" --availability-zone "ap-northeast-2b" --tag-specifications '{"resourceType":"subnet","tags":[{"key":"Name","value":"ecs-prac-subnet-private2-ap-northeast-2b"}]}'
aws ec2 create-internet-gateway --tag-specifications '{"resourceType":"internet-gateway","tags":[{"key":"Name","value":"ecs-prac-igw"}]}'
aws ec2 attach-internet-gateway --internet-gateway-id "preview-igw-1234" --vpc-id "preview-vpc-1234"
aws ec2 create-route-table --vpc-id "preview-vpc-1234" --tag-specifications '{"resourceType":"route-table","tags":[{"key":"Name","value":"ecs-prac-rtb-public"}]}'
aws ec2 create-route --route-table-id "preview-rtb-public-0" --destination-cidr-block "0.0.0.0/0" --gateway-id "preview-igw-1234"
aws ec2 associate-route-table --route-table-id "preview-rtb-public-0" --subnet-id "preview-subnet-public-0"
aws ec2 associate-route-table --route-table-id "preview-rtb-public-0" --subnet-id "preview-subnet-public-1"
aws ec2 allocate-address --domain "vpc" --tag-specifications '{"resourceType":"elastic-ip","tags":[{"key":"Name","value":"ecs-prac-eip-ap-northeast-2a"}]}'
aws ec2 create-nat-gateway --subnet-id "preview-subnet-public-0" --allocation-id "preview-eipalloc-0" --tag-specifications '{"resourceType":"natgateway","tags":[{"key":"Name","value":"ecs-prac-nat-public1-ap-northeast-2a"}]}'
aws ec2 describe-nat-gateways --nat-gateway-ids "preview-nat-0" --filter '{"Name":"state","Values":["available"]}'
aws ec2 create-route-table --vpc-id "preview-vpc-1234" --tag-specifications '{"resourceType":"route-table","tags":[{"key":"Name","value":"ecs-prac-rtb-private1-ap-northeast-2a"}]}'
aws ec2 create-route --route-table-id "preview-rtb-private-1" --destination-cidr-block "0.0.0.0/0" --nat-gateway-id "preview-nat-0"
aws ec2 associate-route-table --route-table-id "preview-rtb-private-1" --subnet-id "preview-subnet-private-2"
aws ec2 create-route-table --vpc-id "preview-vpc-1234" --tag-specifications '{"resourceType":"route-table","tags":[{"key":"Name","value":"ecs-prac-rtb-private2-ap-northeast-2b"}]}'
aws ec2 create-route --route-table-id "preview-rtb-private-2" --destination-cidr-block "0.0.0.0/0" --nat-gateway-id "preview-nat-0"
aws ec2 associate-route-table --route-table-id "preview-rtb-private-2" --subnet-id "preview-subnet-private-3"
aws ec2 describe-route-tables --route-table-ids   "preview-rtb-private-1" "preview-rtb-private-2"
```
* 추후에 테라폼 전환을 꿈꾸며..

### EC2 로 ECR 업로드.
* 일단 docker
  * https://docs.aws.amazon.com/ko_kr/serverless-application-model/latest/developerguide/install-docker.html
  * RedHat 계열~
    ```sh
        sudo yum install git
    ```
* aws cli
  * 가이드 https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
  * 이거보고 설치하긴 하는데, 괜히 기존꺼 삭제한듯... 믿고 쓸걸!
  * 일단!

![](assets/img/posts/2024-12-12-09-09-25.png)
* 일단 실습은 계속 진행중...! image 생성 완료,
* 설정이 잘되었는지 확인하는 방법
  * aws configure list

  Laws cli docker push 하려는데 no basic auth credentials 오류가 떠.EditECR에 Docker 이미지를 푸시할 때 이 오류가 발생하는 것은 ECR 인증이 되지 않았기 때문입니다. 다음 단계로 해결할 수 있습니다:

먼저 aws ECR 로그인 명령어를 실행합니다:
```
aws ecr get-login-password --region ap-northeast-2 | docker login --username aws --password-stdin 727646484333.dkr.ecr.ap-northeast-2.amazonaws.com
```
![](assets/img/posts/2024-12-12-13-15-02.png)
![](assets/img/posts/2024-12-12-13-15-47.png)
* task definition 까지 생성 완료.
* service까지 생성 완료

그럼 요청을 private Subnet에 있는 이 EC2 인스턴스로 연결시키는 방법은?


Private Subnet에 있는 EC2에 접근하는 방법은 몇 가지가 있습니다:

aws Systems Manager Session Manager 사용
가장 권장되는 방법입니다
인터넷 게이트웨이나 배스천 호스트 없이도 접근 가능
EC2에 SSM Agent 설치 필요
VPC 엔드포인트(Systems Manager용) 구성 필요
배스천 호스트(Bastion Host) 사용
Public Subnet에 배스천 호스트를 두고, 이를 통해 Private Subnet의 EC2에 접근
SSH 터널링을 통한 접근

Copy
ssh -i key.pem ec2-user@private-ip -J ec2-user@bastion-public-ip
Application Load Balancer(ALB) 사용
Public Subnet에 ALB를 위치시키고 Private Subnet의 EC2를 타겟 그룹으로 설정
웹 애플리케이션의 경우 유용한 방법
aws Site-to-Site VPN 또는 Direct Connect 사용
기업 네트워크와 aws VPC를 직접 연결
보안성이 높지만 설정이 복잡하고 비용이 발생
VPC 엔드포인트와 Private Link 사용
특정 aws 서비스나 엔드포인트 서비스와 통신할 때 사용
인터넷을 통하지 않는 프라이빗 통신 가능
어떤 방법을 선택할지는 다음을 고려하시면 좋습니다:

보안 요구사항
비용
관리 복잡도
접근 패턴(임시 접속인지 상시 접속인지)
가장 현대적이고 관리가 용이한 방법은 Systems Manager Session Manager입니다. 특별한 이유가 없다면 이 방식을 먼저 고려해보시는 것을 추천드립니다.


![](assets/img/posts/2024-12-12-21-02-43.png)
* 성공?
* alb의 dns:8080 포트로 접속되는 것은 이해했다.
  * 그런데, public subnet에 있는 ec2에서 왜 접속이 안되지?

## 해설을 보자.
* 궁금증
  * EC2에서 연결이 왜 안되었던 것인가?
* IP 블록 실수 -> 수정을 안했네.(다음엔 수정하자.)
* public subnet 클릭수 public IP 활성화 -> EC2생성시 자동 할당을 위해
* 해결
  * EC2를 다른 VPC에 설치했네.. 이런..!
* task정의시 8080 연결 설정 잘함.
* cluster, service private subnet에 만들고
* service는 22 8080 허용.
* fargate의 subnet은 public subnet해야해
![](assets/img/posts/2024-12-12-21-27-40.png)
* alb는 public 존, fargate는 private subnet에 있다.
* 어떻게 갈수 있냐? NAT를 통해서 갈수 있는거!

* 리소스 정리
  * 역순
  * 로드밸런서 삭제 하자~
  * 타겟 그룹 삭제하자~
  * ecs 서비스 삭제하자
  * 태스크 정의는 선택
  * 클러스터 삭제~
  * VPC 가서
  * NAT 부터 삭제~~
  * nat 삭제 상태일때 탄력적 IP 릴리즈
  * ec2 종료~~
  * VPC 가서 VPC 삭제(EC2 삭제를 기다려~)
