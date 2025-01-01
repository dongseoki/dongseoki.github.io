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
