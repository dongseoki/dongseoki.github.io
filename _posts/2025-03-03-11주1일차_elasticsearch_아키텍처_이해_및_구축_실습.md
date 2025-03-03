---
title: 11주1일차_elasticsearch_아키텍처_이해_및_구축_실습
date: 2025-03-03 15:57:57 +0900
categories: [Software Development]
tags: [] # TAG names should always be lowercase
---

## 내용
### elastic search에 대해서.
- JSON 기반 RESTful API를 제공하여 다양한 애플리케이션과 쉽게 연동 가능합니다.
- **Apache Lucene**을 기반으로 개발된 고성능 검색 엔진입니다.
- Full-Text Search는 의미적으로 관련 있는 단어까지 검색 가능
- 역색인(Inverted Index) 방식 사용
2. **토큰화(Tokenization) 및 텍스트 분석**
    - 문장을 **단어(Token) 단위로 분리**하고, 불필요한 단어(Stop Words)를 제거하며, **동의어 및 어근(Stem) 처리**를 수행합니다.

- **어근 분석(Stemming)**
    - 동일한 의미의 단어를 하나로 통합하여 검색 성능을 향상시키는 기법입니다
    - 예)
        - "running", "runner", "runs" → "run"
        - "better", "best" → "good"
- **Proximity 검색** (두 단어 사이의 거리를 고려한 검색)
    - Proximity 검색(근접 검색)은 **검색어 간의 거리를 고려하여 검색 결과를 반환하는 방식**입니다.

- Ranking(랭킹)은 검색 결과에서 **문서의 중요도(Relevance Score)를 평가**하여, 사용자가 원하는 정보를 우선적으로 제공하는 기능입니다.
- ElasticSearch는 **TF-IDF(Term Frequency - Inverse Document Frequency)** 및 **BM25(Best Matching 25)** 알고리즘을 사용하여 검색 결과의 순위를 정합니다.
- TF-IDF는 **문서 내에서 단어의 중요도를 계산하는 대표적인 검색 알고리즘**입니다.
![](assets/img/posts/2025-03-03-16-18-45.png)


## 내 프로젝트의 어디에 넣으면 될지 문의

🔹 로그 시각화(Kibana)는 초기에 도입 가능
🔹 검색 기능은 사용자가 많아지고 데이터가 쌓일 때 추가하는 게 적절
🔹 습관 히스토리 검색, 챌린지 검색, 추천 기능 등에 활용 가능
🔹 운영 부담이 적다면 Meilisearch 같은 가벼운 대안도 고려 가능

지금 당장 ES를 도입할 필요는 없지만, 미래 확장성을 고려해서 데이터 구조를 잘 설계해두는 것이 중요해! 🔥
