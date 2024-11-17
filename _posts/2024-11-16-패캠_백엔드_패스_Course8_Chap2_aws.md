---
title: 패캠_백엔드_패스_Course8_Chap2_aws
date: 2024-11-16 14:20:00 +0900
categories: [fastcampusBackendPath]
tags: [aws] # TAG names should always be lowercase
---

## 실습 가즈아

### 네트워크 운영 이론 정리

- VPC
- default VPC
- user define VPC
- public subnet : VPC를 논리적으로 나눔. 외부 직접 통신 가능
- private subnet : VPC를 논리적으로 나눔. 외부 직접 통신 불가능. 보안성 요구시 사용
- IGW : vpc와 인터넷간의 통신 지원.
  - 퍼블릭 IP 할당 필요.
  - 라우팅 테이블 설정이 되어야, 서브넷 서버들의 외부 통신이 허용.
- NAT 게이트웨이
  - 인스턴스의 소스 IP 주소를 NAT 게이트웨이의 IP 주소(public IP)로 바꿈.
  - 프라이빗 서브넷에 생성된 서버들이 인터넷에 연결될수 있도록 도움.
  - 트래픽을 NAT 게이트 웨이에서 IGW로 라우팅함.

## 실습 user defined VPC

![](assets/img/posts/2024-11-16-15-20-25.png)

## mysql database create

RDS 서브넷 그룹은 RDS DB 인스턴스가 위치할 수 있는 VPC 내의 서브넷을 정의하는 중요한 역할을 합니다. 주요 기능을 설명드리면:

1. 가용영역 분산

- 고가용성을 위해 최소 2개 이상의 가용영역에 있는 서브넷을 포함해야 합니다
- DB 인스턴스의 Multi-AZ 구성 시 이를 통해 다른 AZ로 자동 페일오버가 가능합니다

2. 네트워크 격리

- Private 서브넷에 DB를 위치시켜 직접적인 외부 접근을 차단할 수 있습니다
- 특정 애플리케이션 서버만 접근 가능하도록 제한할 수 있습니다

3. IP 주소 범위 관리

- DB 인스턴스에 할당될 IP 주소의 범위를 정의합니다
- 향후 DB 인스턴스 추가를 고려한 IP 주소 계획이 가능합니다

4. 네트워크 라우팅

- DB 인스턴스의 네트워크 트래픽 경로를 결정합니다
- NAT Gateway 등을 통한 외부 통신 설정이 가능합니다

서브넷 그룹은 RDS 생성 시 반드시 필요한 필수 구성 요소이며, DB의 네트워크 환경을 정의하는 중요한 역할을 합니다. 특별히 더 자세히 알고 싶으신 부분이 있으신가요?

- DB subnet Group
  ![](assets/img/posts/2024-11-16-15-26-23.png)

- parameter groupo
  ![](assets/img/posts/2024-11-16-15-28-21.png)

RDS의 파라미터 그룹과 옵션 그룹은 데이터베이스의 구성과 기능을 제어하는 두 가지 중요한 요소입니다.

파라미터 그룹:

1. 데이터베이스 엔진의 구성 값을 관리

- max_connections: 동시 접속 가능한 최대 연결 수
- character_set: 문자 인코딩 설정
- max_allowed_packet: 최대 패킷 크기
- innodb_buffer_pool_size: InnoDB 버퍼 풀 크기 (MySQL의 경우)

2. 주요 특징

- DB 엔진별로 다른 파라미터 세트 제공
- 동적 파라미터: 즉시 적용 가능
- 정적 파라미터: DB 재시작 필요
- 기본 파라미터 그룹 수정 불가 (복사해서 사용)

옵션 그룹:

1. 데이터베이스의 추가 기능을 활성화

- MySQL의 경우:
  - AUDIT_PLUGIN: 데이터베이스 감사 기능
  - MEMCACHED: 인메모리 캐싱
- Oracle의 경우:
  - SSL
  - NATIVE_NETWORK_ENCRYPTION
  - S3_INTEGRATION

2. 주요 특징

- DB 엔진별로 사용 가능한 옵션이 다름
- 필요한 기능만 선택적으로 추가 가능
- 일부 옵션은 추가 비용 발생 가능
- 보안, 모니터링, 성능 최적화 관련 기능 제공

이 두 그룹의 주요 차이점은:

- 파라미터 그룹: DB 엔진의 기본적인 작동 방식 설정
- 옵션 그룹: 추가적인 기능의 활성화/비활성화

* aws RDS 생성 완료 인증.
  ![](assets/img/posts/2024-11-16-15-35-52.png)
