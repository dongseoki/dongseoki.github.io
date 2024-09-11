---
title: 코딩앙마의 nextJs Dynamic Routes nextLink(2장),
date: 2024-09-09 21:30:00 +0900
categories: [Software Development, FrontEnd]
tags: [nextJs, 코딩앙마] # TAG names should always be lowercase
---

# 내용정리

## Dynamic Routes

- pages/blog/[slug]
- 이런식의 동적 경로를 만들고 싶을 때 쓸 수 있다.

## 다중 동적 라우팅

- 동적 라우팅은 경로 중 하나만 동적으로 설정 가능한 것이 아니라, pages/post/[pid]/[comment].js 와 같이 디렉토리 이름에 [] 를 붙여 중간 경로를 동적으로 만들 수도 있다.
  post/abc/a-comment 와 같은 경로로 접속한다면, router.query 에는 아래와 같은 값이 들어간다.
  출처: https://jake-seo-dev.tistory.com/138 [제이크서 위키 블로그:티스토리]

## Link

- 1. next/link의 Link 컴포넌트

```jsx
  // 구현 코드
  <Link href="/home">HOME</Link>
  // 빌드 결과
  <a href="/home">HOME</a>
```

빌드 후, a tag로 자동 변환된다.
a tag 의 장점을 갖는다. (SEO 최적화, prefetch 가능, 우클릭 기능 사용 가능 등)
페이지 렌더링 시점에, 이동할 주소가 정해져 있는 경우 사용
내부 페이지로의 이동 시, 이 방식을 사용해야 SPA 방식으로 전체 html중 필요한 부분만 리렌더링 된다.

2. router.push()
   빌드 후, 이동할 주소가 html 상에 노출되지 않기 때문에 SEO에 취약하다.
   SEO가 필요 없거나, 되면 안되거나, 숨겨야 할때 사용
   페이지 렌더링 시점에, 이동할 주소가 정해져 있지 않은 경우 사용 (ex. 비동기로 클릭 시점에 이동할 주소가 정해지는 경우 등)
   내부 페이지로의 이동 시, 이 방식을 사용해야 SPA 방식으로 전체 html중 필요한 부분만 리렌더링 된다.
3. a 태그
   html 전체가 relaod 되기 때문에, 외부 링크 일때 사용하며, 일반적으로 내부 링크 이동시에는 의도한 경우가 아니고서는 사용을 지양하는 것이 좋다.

# 3장 서버사이드 랜더링.

![내용](assets/img/posts/2024-09-09-21-46-27.png)

## Static Generation

- getStaticProps

  - page에서 외부 데이터를 가져올 때 사용한다./
  - 빌드 시 데이터를 fetch하여 static 페이지를 생성

- getStaticPath
  - 페이지 경로가 외부데이터에 연동된다.
  - 동적 라우팅을 사용할 때, 어떤 페이지를 미리 Static으로 빌드할 지 정하는 api
  - pages/\*\*/[id].tsx 형태의 동적 라우팅 페이지 중, 빌드 시에 static하게 생성할 페이지를 정함

## Server Side Rendering

- 정의를 하고가자면, getStaticProps는 빌드 시에 데이터를 가져옵니다. 그래서 한번 빌드되고 나면 정적으로 움직이지 않습니다. 물론 데이터 조작을 따로 하면 가능하겠지만요..
  기본적으로 빌드시!!에 처음 가져오는 데이터라고 보시면 됩니다.
  getServerSideProps는 해당 페이지가 요청될 때 마다!! 재 요청됩니다. 따라서 페이지를 이동할 때 마다 새로 불러와 느리지만 동적인 구성이 가능하다는 점이 장점입니다.

# 참고자료

- https://nextjs.org/docs/pages/building-your-application/routing/dynamic-routes
- https://jake-seo-dev.tistory.com/138
- https://velog.io/@1nthek/Next.js-Link-router.push-a-tag-%EC%96%B4%EB%96%BB%EA%B2%8C-%EB%8B%A4%EB%A5%BC%EA%B9%8C
- https://velog.io/@taeung/Next.js-getStaticProps-%EC%82%AC%EC%9A%A9%EA%B8%B0
- https://nextjs.org/docs/pages/building-your-application/data-fetching/get-static-props
