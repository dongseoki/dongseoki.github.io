---
title: 10주2일차_k8s_pod와_deployment_관리_실습
date: 2025-02-24 09:05:00 +0900
categories: [Software Development]
tags: [] # TAG names should always be lowercase
---

## 필기 내용
- kubectl apply -f <파일명>.yaml을 통해 YAML 파일 기반 배포
- 실행 중인 리소스를 조회 (`kubectl get pods`, `kubectl get deployments`)
- 리소스의 상태와 이벤트 확인 (`kubectl describe <리소스> <이름>`)
- CPU 및 메모리 사용량 확인 (`kubectl top pods`, `kubectl top nodes`)
- 컨테이너 로그 조회 (`kubectl logs <pod 이름>`)
- 문제 발생 시 이벤트 확인 (`kubectl get events`)
- Kubernetes 내부 네트워크를 통한 접근 및 트러블슈팅 (`kubectl port-forward`, `kubectl proxy`)
- 서비스 및 네임스페이스 관리
- **컨테이너 배포 및 롤백**
    - 애플리케이션 업데이트 및 롤백 (`kubectl rollout undo deployment/<deployment-name>`)
    - 블루-그린 배포 및 카나리 배포와 같은 배포 전략 관리

- kubectl은 Kubernetes 클러스터를 운영하는 핵심 도구로서, 개발자와 운영자가 애플리케이션을 배포, 모니터링, 디버깅, 문제 해결할 때 필수적입니다.
### 파드의 특성
- **임시성 (Ephemeral nature)**
    - Pod는 일시적입니다. 즉, Pod는 불변이 아니며, 주로 재시작할 때는 새 IP 주소를 받게 됩니다. 이러한 특성 때문에, Pod는 스토리지와 같은 지속적인 리소스와 결합하여 사용되는 경우가 많습니다.
5. **CrashLoopBackOff**
    - 컨테이너가 반복적으로 시작되었다가 실패하는 상태입니다.
#### 1.2.1 Pod 생명주기

### 1.3 Kubernetes Deployments

- **Deployment**는 Kubernetes에서 애플리케이션의 선언적 업데이트를 제공하는 API 객체입니다.
- Deployment를 사용하면 상태를 안정적으로 유지하면서 애플리케이션 또는 서비스의 원하는 상태를 설명하고, Kubernetes가 목표 상태를 현재 상태에 맞추도록 할 수 있습니다.
- Deployment는 주로 상태가 없는 (stateless) 애플리케이션을 관리하는데 적합합니다.
### NodePort or LoadBalancer로 서비스에 접근
kubectl expose deployment nginx-apop --type=NodePort --port=80
### 1.3.5 (정리) 클러스터 외부에서 클러스터 앱 접근

- kubectl service 80 포트를 이용하도록 컨테이너를 실행했지만 [localhost:80](http://localhost:80) 으로 접속이 불가능합니다.
- 이는 쿠버네티스 내부에서 사용하는 네트워크가 외부와 격리되었기 때문입니다.
- 쿠버네티스 내부에서 실행한 컨테이너를 외부에서 접근하려면 service 를 사용해야 합니다.

selector:
  matchLabels:
    app: nginx

selector: 파드를 선택하는 기준을 정의하는 필드입니다.
matchLabels: 파드의 라벨과 일치하는지 확인하는 기준을 정의합니다.
app: nginx: 파드의 라벨 중 app 키가 nginx 값을 가지는 파드를 선택합니다.
이 설정은 app: nginx 라벨을 가진 파드만 이 Deployment에 의해 관리되도록 합니다. 이 라벨은 template 섹션의 metadata.labels에서 정의된 라벨과 일치해야 합니다.
### lens 에 대해
- **Lens**는 Kubernetes 클러스터를 관리하기 위한 강력한 오픈 소스 IDE(Integrated Development Environment)
- Lens는 클러스터의 실시간 상태를 보여주며, 리소스를 직관적으로 관리할 수 있는 그래픽 인터페이스 제공
- **주요 기능**
    1. **멀티 클러스터 관리**
        1. 여러 Kubernetes 클러스터를 하나의 Lens 인터페이스에서 동시에 관리

### 4. (부록) k8s 용어집

1. **Pod (파드)**
    - 파드는 Kubernetes에서 스케줄링 가능한 가장 작은 단위입니다. 하나 이상의 컨테이너를 포함할 수 있으며, 이 컨테이너들은 스토리지, 네트워크를 공유하고, 어떻게 실행될지에 대한 방식을 지정합니다.
2. **Node (노드)**
    - 노드는 파드가 배포되는 물리적 또는 가상의 기계입니다. 각 노드는 마스터에 의해 관리되며, 파드의 운영을 지원하기 위한 리소스(스케줄링, 실행, 모니터링 등)를 제공합니다.
3. **Service (서비스)**
    - 서비스는 일련의 동적 파드에 대한 지속적인 접근을 제공하는 추상적인 개념으로, 로드 밸런싱, 서비스 디스커버리, 고정 IP 주소를 포함합니다.
4. **Deployment (디플로이먼트)**
    - 디플로이먼트는 파드와 레플리카셋의 선언적 업데이트를 관리합니다. 이를 통해 사용자는 애플리케이션을 롤아웃, 업데이트 및 롤백할 수 있습니다.
5. **ReplicaSet (레플리카셋)**
    - 레플리카셋은 한 개 이상의 파드 복사본을 유지하도록 보장합니다. 이는 파드의 가용성을 유지하는 데 중요합니다.
6. **ConfigMap (컨피그맵)**
    - 컨피그맵은 구성 데이터를 키-값 쌍으로 저장하여 애플리케이션 코드의 구성 정보를 파드에서 분리할 수 있게 해줍니다. 이를 통해 애플리케이션을 재배포하지 않고도 설정을 변경할 수 있습니다.
7. **Secret (시크릿)**
    - 시크릿은 비밀번호, OAuth 토큰, SSH 키와 같은 민감한 정보를 저장하는데 사용됩니다. 이 정보들은 시크릿을 사용하여 안전하게 파드에 주입될 수 있습니다.
8. **Volume (볼륨)**
    - 볼륨은 파드가 존재하는 동안 데이터를 유지할 수 있는 디렉토리입니다. 다양한 유형의 볼륨이 지원되며, 파드 내의 컨테이너 간, 또는 파드의 인스턴스 간에 데이터를 공유할 때 사용됩니다.
## Action Plan

## 수업 내용 필기 정리.

