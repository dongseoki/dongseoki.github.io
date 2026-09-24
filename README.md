# 시작 방법.


# 로컬에서 블로그를 실행하는 방법

## 실행환경 조성(Ubuntu)
1. rvm install(link : https://github.com/rvm/ubuntu_rvm)
2. reboot
3. rvm install ruby-3.3.10
4. ruby --version
5. gem --version
6. bundle --version
7. bundle install

## 이미지 붙여 넣기를 위해서
vscode paste image 설치 및 실행.(해당 프로그램 멕 정상동작. 우분투 실패. 윈도우 아직 테스트 안됨.)

## 로컬에서 블로그 실행
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
