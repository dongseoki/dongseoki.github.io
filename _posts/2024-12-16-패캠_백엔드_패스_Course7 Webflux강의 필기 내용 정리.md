---
title: 패캠_백엔드_패스_Course7 webflux강의 필기 내용 정리
date: 2024-12-15 09:55:00 +0900
categories: [fastcampusBackendPath]
tags: [webflux, 대용량 ] # TAG names should always be lowercase
---

## 필기 가자
* CPU Bound 처리 vs IO Bound 처리
* spring webflux 는 IO Bound 처리에 유리하다
* IO바운드 이야기할떄 multiplexing 이야기를 했는데, 좀더 찾아봐야함.
  * 다수의 소켓 이벤트 등록
  * 기존보다 Thread사용량이 감소,
* MVC
  * 동기식 프레임워크의 일종.
* Reactive
  * 대량 접속에 유리.
*

### Reactive 이론
* Reaactive Stream
  * onNext 로 성공처리.
* back pressure
  * 불균형을 다루기 위한 방법

### Reactor 실습
### flux 실습
Flux.just, range, fromIterable

* onNext가 여러번 호출되는 것은 log()로 확인 가능.

### Test flux
* Step Verifier -> 예시 설명.
* mono는 에러 처리에도 적합하다.
* expectNext("a", "b", "c");
