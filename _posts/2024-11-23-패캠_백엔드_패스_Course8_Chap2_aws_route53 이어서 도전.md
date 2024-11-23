---
title: 패캠_백엔드_패스_Course8_Chap2_aws_route53 이어서 도전
date: 2024-11-23 16:20:00 +0900
categories: [fastcampusBackendPath]
tags: [aws] # TAG names should always be lowercase
---

## 실습 가즈아

### EC2 연결이 안되던 이슈가 있었다.
* 해결 했다.
* 원인 : default VPC의 IGW의 부재.
* 내가 예전에 아 다 지워야해 해서 싹다 지웠던 것이였다.
* 그래서 했던 조치는
* https://velog.io/@tlsalsckd13/AWS-%EA%B8%B0%EB%B3%B8-VPC-%EB%A7%8C%EB%93%A4%EA%B8%B0
* 여기 글을 참고하여
* IGW생성.
* 라우팅 테이블에 모든 외부 연결에 만든 IGW연결.
* 또한 route table 에 연관된 서브넷으로 하나 만들어져있던 서브넷을 연결했다.
  * 이것으로 모든 외부 접속은 인터넷 연결이 가능해졌고
  * 로컬에서 연결도 가능해졌다.

# 그리고
* http://ec2-43-201-54-144.ap-northeast-2.compute.amazonaws.com/
* http://project-test.fsdeveloper.store/
* amazon route53 실습 성공!


## 회고
* 좀 오래 걸린 느낌.
* 일단 트러블 슈팅하며 명확히 알게 된것이 조음.
* K
  * 차분히 대화를 통해 지식을 늘린것.
* P&T
  * 오래 걸림 이슈
    * 실습 자체가 오래 걸린다면
      * 전부 다 해볼건 아니고 새로운 것들만 조치.
  * 기타?
    * 초 집중 필요.
      * 뽀모도로 시간 초과시 잠시 빠져나오기 연습하기.

## lab 최종 실습 가즈아
![](assets/img/posts/2024-11-23-18-04-47.png)

![](assets/img/posts/2024-11-23-18-04-56.png)
* vpc and more로 생성까지 했다!
* 비용이 살짝 걱정되지만, 다음에 할게 좀 남았으니 그 부분을 추후 고민해보자.
