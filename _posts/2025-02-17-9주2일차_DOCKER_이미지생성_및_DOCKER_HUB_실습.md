---
title: 9주2일차_DOCKER_이미지생성_및_DOCKER_HUB_실습
date: 2025-01-25 09:05:00 +0900
categories: [Software Development]
tags: [] # TAG names should always be lowercase
---

## 필기 내용
- **`.dockerignore` 파일이 필요한 이유**
    1. **빌드 속도 향상** → 불필요한 파일을 제외하여 Docker 컨텍스트 크기를 줄임
    2. **보안 강화** → 환경 변수 파일(`.env`), 인증 정보(`.git`, `node_modules`) 등이 이미지에 포함되지 않도록 방지
    3. **이미지 크기 최소화** → 최적화된 Docker 이미지를 생성하여 배포 용량을 줄


## Action Plan

## 수업 내용 필기 정리.
```sh
docker push dongseoki671/my-flask-app:v1.0
```
