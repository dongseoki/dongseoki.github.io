---
title: 10주4일차_k8s_볼륨__Persistent_Volumes__StatefulSets의_이해_및_실습
date: 2025-02-28 16:20:00 +0900
categories: [Software Development]
tags: [] # TAG names should always be lowercase
---

## 필기 내용
### **3.1.2 PV와 일반 볼륨의 차이**

- 일반 볼륨은 파드에 직접 정의되고, 파드와 함께 생성 및 삭제됩니다. 반면, PV는 파드와 독립적으로 존재하며, 파드가 삭제되어도 데이터는 유지됩니다.
- PV는 클러스터 전체에서 사용할 수 있으며, 다양한 파드와 재사용될 수 있습니다.

### 3.2 Persistent Volume Claims (PVC)

#### **3.2.1 PVC의 역할과 정의**

- Persistent Volume Claim (PVC)은 사용자가 스토리지를 요청하는 방법입니다. 사용자는 필요한 스토리지의 크기와 접근 모드를 PVC를 통해 정의하고, Kubernetes는 이 요구사항을 만족하는 PV를 찾아 바인딩합니다.
- PVC는 PV에 대한 요청을 나타내며, 한 번 바인딩되면, 해당 PV는 다른 PVC에 의해 요청될 수 없습니다.
## Action Plan

## 수업 내용 필기 정리.

