---
title: 패캠_백엔드_패스_Course8_Chap4_ECR fargate lab final
date: 2024-12-12 08:30:00 +0900
categories: [fastcampusBackendPath]
tags: [ECR, ECS, AWS, Fargate] # TAG names should always be lowercase
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

먼저 AWS ECR 로그인 명령어를 실행합니다:
```
aws ecr get-login-password --region ap-northeast-2 | docker login --username AWS --password-stdin 727646484333.dkr.ecr.ap-northeast-2.amazonaws.com
```
![](assets/img/posts/2024-12-12-13-15-02.png)
![](assets/img/posts/2024-12-12-13-15-47.png)
* task definition 까지 생성 완료.