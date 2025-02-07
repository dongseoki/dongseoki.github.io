---
title: 7주2일차_트랜잭션_전파_옵션과_DB_Read_Write_분리
date: 2025-02-04 09:05:00 +0900
categories: [Software Development]
tags: [transaction] # TAG names should always be lowercase
---

## 필기 내용

## Action Plan

## 수업 내용 필기 정리.

* Async로 실행된 쓰레드는 별도의 트랜잭션을 사용한다.
* 쓰레드간 트랜잭션 공유는 안된다.
*  Q : spring boot 에서 transaction required_new를 쓰면 같은 db 커넥션내에서 트랜잭션이 분리되는거니
  * A : 결론: REQUIRES_NEW는 보통 새로운 DB 커넥션을 생성하여 트랜잭션을 분리합니다. 🚀
* 오로라에서 마스터 슬레이브를 동기화하는 원리를 배워둘 필요는 있다.
* 마스터 슬레이브가 분리되어있을 경우 readonly가 true면 슬레이브로, false 면 마스터 노드로 요청이 간다.
* spring application.yaml도 master, slave 분리되게 됨.
* hikari 는 connection pool 과 관련된 에러라고 볼 수 있다.

## 실습
* spring application.yaml도 master, slave 분리 설정.
* DataSourceConfiguration 작성.
