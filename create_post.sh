#!/bin/bash

# 인자로 제목을 받습니다.
TITLE=$1

# 날짜 포맷을 설정합니다.
DATE=$(date +"%Y-%m-%d")
TIME=$(date +"%H:%M:%S +0900")

# 파일명용으로 띄어쓰기를 언더스코어로 변환합니다.
FILENAME_TITLE=$(echo "$TITLE" | tr ' ' '_')

# 파일 이름을 설정합니다.
FILENAME="_posts/${DATE}-${FILENAME_TITLE}.md"

# 파일 내용을 작성합니다.
cat <<EOL > $FILENAME
---
title: ${TITLE}
date: ${DATE} ${TIME}
categories: []
tags: [] # TAG names should always be lowercase
---

## 내용

EOL

echo "Post created: $FILENAME"
