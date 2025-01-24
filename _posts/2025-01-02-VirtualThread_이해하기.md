---
title: VirtualThread_이해하기
date: 2025-01-02 14:55:00 +0900
categories: [Software Development]
tags: [virtualThread] # TAG names should always be lowercase
---

## 필기 가자

* 기존 park 모델과의 호환성.
  * jdk17 vs jdk21
    * 현재 쓰레드가 가상 쓰레드드일경우만 가상쓰레드 스위칭을 사용하도록 설정.

* IO 바운드 작업에서 높은 성능상 이점을 보임. 단 CPU 바운드에서는 기존 쓰레드모델에 비해 성능이 안좋음.
* 성능테스트 결과 Virtual Thread의 성능이 Kotlin coroutine에 비해 37% 좋은 성능을 보였습니다.

## virtualThread 마치며
마치며
CPU intensive 환경이 아닌, 네트워크 I/O가 다수 발생하는 웹서버 환경에서는 하나의 호출에 하나의 스레드를 점유하는 기존 Spring MVC/Tomcat 모델은 큰 부담으로 작용했고, non-blocking single thread 모델인 Netty/webflux 모델이 그 단점을 해결하며 부상했다. 하지만 학습이 어렵고, 숙련도가 부족해 block을 한 번이라도 잘못 사용하는 순간 전체 서비스가 망가지기 때문에 쉽게 도입하긴 쉽지 않다고 생각한다. 레거시 서비스의 경우 webflux로 마이그레이션하기도 어려울 것이다.

Virtual Thread의 등장은 non-blocking single thread 모델을 사용하지 않아도 된다고 말하고 있다. 실제로 CPU intensive 환경이 아니라면 non-blocking single thread 모델만큼이나 효율을 잘 내고 있다.

추후 많은 Java 진영에서 synchronized를 제거하는 등, Virtual Thread를 사용하기 위한 준비가 된다면 Java 진영의 non-blocking single thread 모델의 자리에 Virtual Thread가 들어갈지도 모르겠다.

## 최근 스프링 프레임워크에서 synchronized 대신 ReentrantLock으로 전환하는 움직임과 이유
최근 스프링 프레임워크에서 synchronized 대신 ReentrantLock으로 전환하는 움직임이 있습니다. 이는 주로 다음과 같은 이유들 때문입니다:

가상 스레드(Virtual Thread)와의 호환성: JDK 21에서 도입된 가상 스레드는 효율적인 동시성 처리를 가능하게 합니다. 그러나 synchronized 블록은 가상 스레드와 함께 사용할 때 확장성 문제가 발생할 수 있습니다. 이는 synchronized가 JVM 내부적으로 구현되어 있어, 가상 스레드가 블로킹될 때 캐리어 스레드도 함께 블로킹되기 때문입니다. 반면, ReentrantLock은 Java로 구현되어 있어 가상 스레드와의 호환성이 높습니다.
VELOG

유연한 락 제어: ReentrantLock은 synchronized에 비해 락을 더 유연하게 제어할 수 있는 기능을 제공합니다. 예를 들어, 락을 시도해보고 실패하면 다른 작업을 수행하거나, 일정 시간 동안만 락을 시도하는 등의 기능이 가능합니다. 또한, 락을 메서드 간에 걸쳐 사용할 수 있어 복잡한 동기화 시나리오에 유리합니다.
STACK OVERFLOW

공정성 정책 지원: ReentrantLock은 공정성(fairness) 정책을 설정할 수 있어, 락을 기다리는 스레드들 간의 공정한 접근을 보장할 수 있습니다. 이는 특정 스레드가 락을 독점하는 것을 방지하여 시스템의 응답성을 향상시킬 수 있습니다.
STACK OVERFLOW

이러한 이유들로 인해, 스프링 프레임워크를 비롯한 자바 애플리케이션에서 synchronized에서 ReentrantLock으로의 전환이 고려되고 있습니다.

# 참고자료
- https://techblog.woowahan.com/15398/
- https://d2.naver.com/helloworld/1203723
