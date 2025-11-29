---
title: 게시글 생성 테스트 및 참고 자료 정리.
date: 2024-01-02 10:43:00 +0900
categories: [Tutorial]
tags: [jekyll, test, 수고했어] # TAG names should always be lowercase
---

# 게시글 작성 규칙.

```md
---
title: 게시글 생성 테스트 및 참고 자료 정리.
date: 2024-07-16 10:43:00 +0900
categories: [tutorial, tutorial]
tags: [jekyll, test, 수고했어] # TAG names should always be lowercase
---
```

# mac에서 설치하는 방법
* https://1221jyp.com/posts/github-blog_1/
* 설치 ruby 버전 : 3.3.10

# 로컬에서 블로그를 실행하는 방법

- 로컬에서 블로그를 실행하는 명령어

```sh
bundle exec jekyll serve
```

```sh
# 댓글 기능 테스트.
JEKYLL_ENV=production bundle exec jekyll serve
```

- 로컬 테스트 블로그 주소
  - http://127.0.0.1:4000/
- 운영 블로그 주소
  - https://dongseoki.github.io/

# 도움을 받은 참고자료

- Github 블로그 만들기
  - https://devpro.kr/posts/Github-%EB%B8%94%EB%A1%9C%EA%B7%B8-%EB%A7%8C%EB%93%A4%EA%B8%B0-(4)/
- 이 블로그의 시작 포인트.
  - https://github.com/cotes2020/chirpy-starter

# 앞으로 해야할 작업

- 포스팅 자주하기!
- 블로그 업그레이드!

# 주의사항

- 게시글 제목에 ":" 넣지 말것. 기타 특수문자 금지
- 태그에 큰따옴표 넣지 말것.
