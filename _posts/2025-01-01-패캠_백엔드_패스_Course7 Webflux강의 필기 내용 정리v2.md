---
title: 패캠_백엔드_패스_Course7 Webflux강의 필기 내용 정리v2
date: 2025-01-01 09:55:00 +0900
categories: [fastcampusBackendPath]
tags: [Webflux, 대용량 ] # TAG names should always be lowercase
---

## 필기 가자
* flex에서
  * onNext가 여러번 호출 됨.
    * log()로 확인이 가능.
* Mono.empty() log
  * onNext를 보내지 않았다 이런것 확인 가능.
* flux를 test하기 위해서는?
  * StepVerifier를 사용함.
    * expectNext("a", "b", "c")
* mono는 에러처리에도 적합

### Operator에 대해서
* 스트림 데이터를 어떻게 처리하는가?
  * flatMap, flat, take, map 의 특징을 살펴봄

### Reactor
* concatMap 실습, flatMapMany, delayElements
* mono.merge, flux.merge좆재.
* flux.zip : 값을 합쳐서 반환.
* delaySequence
  * limitRate
  * sampling
* scheduler
* publishOn : 시점부터 사용할 쓰레드 관리.

### R2DBC 실습
* 커넥션을 바로체크 안하기 때문에 따로 검증 코드 추가가 필요함.
  * 오류시 어플리케이션 종료도 가능.
* JPA와 사용방식은 유사했음.
* 리턴도 여기서 Mono랑 Flux를 쓰는 양식을 보임.
  * Mono<ResponseEntity<>>
    * switchIfEmpty 도 사용함.
* 메서드 명 가지고 쿼리를 만드는 기능이 spring-data-jpa와 유사.
* @transient : DB에 persist 대상이 아님을 명시할 때 사용.
* 커스텀 쿼리의 사용 방식 : databaseClient라는 것을 사용했었음.

### Reactive Redis
* 이것도 초기 검증 추가 로직 필요.
* ReactiveRedisTemplate 활용.
* 공식문서 참고.
* unlink 기능
  -  비동기로 key를 삭제하는 기능임.

### 성능 테스트
* Jmeter 그룹 테스트 시 그룹 enable, disable 기능 활용 필요.

### BlackHound
* block로직검출
  * build option 추가.
* intellij 실행시 검사 예외처리도 가능함.

### 대기열 시스템
* 랭킹 구현을 위해 redis sortedSet 활용.
* key value로 key는 userId, value는 unix timestamp를 활용.
* value값 기준으로 소팅이 됨.
* 동일한 값이 다시오면 어떻게 되는가?
* HttpStatus.conflict를 사용하는 면모를 보임.

#### 진입 요청 API
* 진입 가능성 조회
* 진입 허용
* EmbededRedis 추가
* stepVerifier 사용

#### 대기열 웹페이지

#### 대기열 이탈
* 대기열 대기시 쿠키값 전달.
* 쿠키값 없으면 다시 뒤로 보내기.(이탈로 간주)
* 쿠키가 포트는 구분 안한다고함.
