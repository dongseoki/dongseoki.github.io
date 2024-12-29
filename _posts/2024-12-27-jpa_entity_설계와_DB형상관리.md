---
title: jpa_entity_설계와_DB형상관리
date: 2024-12-27 14:55:00 +0900
categories: [Software Development]
tags: [jpa] # TAG names should always be lowercase
---

## 필기 가자

get vs find 네이밍 규칙
get:
데이터를 반드시 반환해야 하는 경우 사용합니다.
주로 캐시나 메모리에서 데이터를 가져오는 로직에 적합합니다.
public User getUserById(Long id) {
    return userRepository.findById(id)
        .orElseThrow(() -> new EntityNotFoundException("User not found"));
}
​
find:
데이터가 존재하지 않을 수 있는 경우 사용합니다.
주로 Optional을 반환하거나 데이터가 없을 가능성을 고려한 로직에 적합합니다.
public Optional<User> findUserByEmail(String email) {
    return userRepository.findByEmail(email);
