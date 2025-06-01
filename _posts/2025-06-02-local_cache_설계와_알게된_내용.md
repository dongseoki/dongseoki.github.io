---
title: local cache 설계와 알게된 내용
date: 2025-06-02 01:01:25 +0900
categories: [Software Development, Software Debugging]
tags: [local cache] # TAG names should always be lowercase
---

## 내용

### 동기

- 회사 상품 목록 api 중 상당히 느린 코드가 있었다.
- 해당 코드는 코드 구조가 상당히 복잡하여, 속도 개선을 위해서 아래와 같은 선택지가 있었다.

1. 해당 상품목록 api를 사용하는 프론트 코드에서 반드시 사용하는 response만 확인하여, 성능이 개선된 v3 api 개발.
2. 반복적으로 호출하는 상품, 아이템에 캐싱을 적용

- 그 중 2번이 궁금해서 2번에 대한 부분을 찾아보고, 테스트 해보았다.

### 과정

1. spring boot actuator를 쓰면 jvm 사용량을 그 순간에 구체적인 수치로 알수있다.
   1. heapdump로 메모리 도 덤프할 수 있다.
2. intellij profiler, actuator의 결합이면 bean도 어떤것을 사용하는지 쉽게 알 수 있다.

- 아래는 캐시의 성능 확인에 도움이 되었던 path 들이다.
  ```jsx
  http://localhost:1650/actuator/metrics/jvm.memory.used?tag=area:heap
  http://localhost:1650/actuator/metrics
  http://localhost:1650/actuator/caches
  ```

### 결론.

- 코드의 복잡성이 가장 큰 이슈고, 캐시도입은 장기적인 관점에서의 문제 해결은 아니라고 판단함.
- api 구조 개선하여 v3로 만드는 방법으로 추후 개선하기로 함.

### 참고 자료

https://mangkyu.tistory.com/342

https://www.jetbrains.com/ko-kr/pages/intellij-idea-profiler/

https://youseong.tistory.com/68

### 참고 캡쳐본.

![](assets/img/posts/2025-06-02-01-04-40.png)
![](assets/img/posts/2025-06-02-01-06-22.png)
![](assets/img/posts/2025-06-02-01-06-32.png)
