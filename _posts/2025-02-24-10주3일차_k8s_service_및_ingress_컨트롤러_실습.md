---
title: 10주3일차_k8s_service_및_ingress_컨트롤러_실습
date: 2025-02-26 09:05:00 +0900
categories: [Software Development]
tags: [] # TAG names should always be lowercase
---

## 필기 내용
### 학습 목표
- Kubernetes의 Service 및 Ingress 컨트롤러를 통해 외부 트래픽을 클러스터 내부의 애플리케이션으로 라우팅하는 방법을 학습하고 실습합니다.
- Service와 Ingress의 개념을 이해하고, 실제 설정을 통해 애플리케이션을 외부에 노출하는 경험을 합니다.


`kubelet`은 컨테이너의 상태를 모니터링하고 관리하기 위해 여러 종류의 프로브(probe)를 사용합니다. 이 프로브들은 컨테이너가 제대로 동작하고 있는지 확인하고, 필요한 경우 자동으로 복구 작업을 수행할 수 있도록 합니다.

**프로브(Probe)** 는 컨테이너가 정상적으로 동작하는지, 트래픽을 받을 준비가 되었는지, 또는 아직 초기화 중인지 **애플리케이션의 상태 등을 확인하기 위해 사용되는 진단 도구**

### **1.1 Service 타입**

1. **ClusterIP (기본)**
2. NodePort
3. LoadBalancer


1.2 Service 사용 실습 할 차례.
## Action Plan

## 수업 내용 필기 정리.
selector: 이 서비스가 트래픽을 라우팅할 파드를 선택하는 데 사용되는 레이블 셀렉터입니다.
app: nginx-for-svc: app 레이블이 nginx-for-svc인 파드를 선택합니다.
