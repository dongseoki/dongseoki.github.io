---
title: 패캠_백엔드_패스_Course7 redis강의 필기 내용 정리
date: 2024-12-15 09:55:00 +0900
categories: [fastcampusBackendPath]
tags: [redis, 대용량 ] # TAG names should always be lowercase
---

## 필기 가자
* 기존의 톰캣을 사용한 was의 특징
  * 요청에 대응하는 1대1 쓰레드 1개가 대응
    * 단점 : 대용량 트래픽 처리시, 메모리 낭비가 있을수 있음.
* 적은 메모리로 대량 IO를 어떻게 처리할까?
  * 이때 webflux라는 비동기 web framework 를 이용하면 가능.

### redis
* 6.2버전 쓸거임.
* memory 저장 방식 vs 보조기억장치 저장 방식.
  * 약 20배의 성능 차이가 발생함.
* 레디스 활용 : leader board 구현, pubsub시.
* redis-cli monitor 명령어를 통해 어떤 명령어들이 실행되는지 확인가능.

### redis type
* INCRBY
  * 동시성 이슈에 대응할때 유리
  * 기존 값 기준으로 증가.

* 실습 예시들.
```sh
EXPIRE LANG 10
TTL LANG

# 동기 삭제시
DEL SOME

# 비동기 삭제시
UNLINK SOME

MEMORY USAGE

```

* Jedis
  * redis pipelining
    * 요청 여러개를 한번에 처리할 때 유리.

### data type list
* Block Command : 동기 명령어
  * ex) BLPOP
    * 이것은 값을 꺼낼때까지 기다림.
    * LPOP은 없으면 말음.

#### Sorted Set
* set에 키 벨류를 넣을 수 있음.

#### geo spacial
* 왜 좌표 기능을 넣지? 실제로 쓰나의 의문을 가짐.

#### Bitmap
* true, false만을 가지는 데이터를 저장할때 효과적인 레디스 자료구조
  * set과 bitmap 자료구조를 비교했었음.
* 적어두기로는 메모리 400배차이 와우

### Transaction
* transaction 요청이 끝나고서만 그 결과를 확인 가능
  * RDB랑 다른점. rdb는 해당 transaction 요청 내에서 조회시 중간 상태가 반영됨.
* MULTI : 시작!
  * EXEC : 진행시켜!
  * DISCARD :취소
* WATCH : 값을 모니터링하다가 그 값이 변경되어버리면 transaction rollback을 해버림.

### keys, scan
* O(N)으로 동작
* redis-cli --pipe
* .. --latency :
```
scan 2305234 match * cont 100
```

### 캐시 실습
* spring initializer 이용
* ApplicationRunner를 구현하여, 초기 동작 프로그램을 작성했었음.! webMvc프로젝트에! Wow

### spring boot cache
* opsForValue set
* getter 누락, 기본 생성자.
* @redisCache
* evict :삭제 기능.
* createJedisPool
  * 이것을 빈등록해서 실습.
* java redis client : lettuce, jedis
* redisTemplate : 데이터 변환, 직렬화를 담당.
* CacheConfig설정 필요.
  * 빈등록하여 공통 설정을 반영.
  * @Cachable 실습.
    * redisCacheManager를 사용하여 ttl 적용이 가능함.


### spring boot session store
* spring boot session
* spring boot redis
* session은 HMSET으로 저장됨.

### spring pubsub
* addMessageListener
* redisMessageListenContainer 의 빈등록이 필요함.
#### 이번엔 publish
* redCOT.cASend

### 19 mornitoring
```sh
--stat
--bigkey
--memkey
--latency
```
* Cloud Native Foundation
* maxMemoryPolicy를 레디스에 설정 가능.

* 메모리 정책 
  * 메모리 정책은 maxmemory-policy 설정 값으로 정하면 된다. 이 값도 redis.conf 파일이나 config set 명령문으로 변경할 수 있다. 
  * MAX MEMORY만큼 메모리를 사용하게 되면, 메모리 정책에 따라 과거에 만들어진 키들이 삭제된다.  
출처: https://americanopeople.tistory.com/179 [복세편살:티스토리]
* 삭제 정책
  * allkeys-random
  * allkeys-lru
* 컨테이너 이름으로 도메인 이름 사용이 가능.
* redis exporter : 프로메테우스가 redis Exporter 를 이용해서 레디스 정보를 조회한다고 들음.
*  그라파나용 redis 대쉬보드도 있음.

### 20. Replication
* redis.conf에서 설정 가능.
* offset을 활용하면 끊어진 부분부터 동기화도 가능함.
* master 재실행시 연결 확인하는 테스트도 했었음.
