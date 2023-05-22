# 간단한 개념

**CoreBlueTooth는 사전지식이 많이 필요하다. 하지만, 간단하게만 알아보고 구현해보자.**

## BlueTooth와 BLE

![](https://hackmd.io/_uploads/ByGBSMtSh.png)


**BlueTooth의 정의**

- 근거리 무선 통신 기술 규격
- 휴대폰, 노트북, 스마트워치 드으이 기기 사이 데이터 통신
- 지속적으로 발전 (현재 v5.3까지 출시)
- 블루투스는 두가지로 나눠진다. (Classic, BLE)
    - **BlueTooth Classic**
        1. 높은 데이터 전송속도
        2. 높은 전력소비
        3. 대용량 데이터 전송 적합
        4. ex) 음악 스피커, 헤드폰
    - **BLE(Low Energy)**
        1. 4.0부터 지원(iPhone6 → 4.0 / 4.2)
        2. 낮은 데이터 전송 속도
        3. 낮은 전력 소비
        4. 적은 양의 데이터 전송 적합
        
        ex) 스마트워치, 비콘 등 IOT 기기
        

![](https://hackmd.io/_uploads/BJ7vBMtrn.png)


<aside>
❗ **말로만 들었을땐, BLE가 무조건 좋은 기술인 것 같은데? 하는 생각이 들 수 있다.
하지만, 이는 틀린생각이다. 용도 / 호환성을 고려해서 선택해야한다.**

</aside>

---

## BLE를 사용하는 앱들

![](https://hackmd.io/_uploads/BkUtBfKSn.png)
![](https://hackmd.io/_uploads/HJdRBzFBn.png)







- **스타벅스:**
방문매장 자동 식별 시 사용 ( 이는 CoreLocation일 것 같지만, CoreBlueTooth를 사용하는듯? & 초음파기능도 같이 사용한다고함.)
- **쏘카, 킥고잉, 일레클:**
이동수단 대여 시 사용함.
- **픽데이, 오므론 커넥트:**
체중계 연동앱, 혈압계

<aside>
❗ **들어보니까 아빠가 젤 많이쓰는 Zwift 스마트바이크와 같이 사용되는 
‘Magene Utility’ 앱에서 제일 많이 사용되는 기술일듯?

- 사용자 기기에 이 앱을 설치하면, 스마트바이크와 연동해서 심박수체크, 속도 & 케이던스, 가변저항 등을 사용할 수 있다. 이 원리가 아닐까?
- 그리고, 위 기능은 큰 데이터를 전송하는게 아니니까 블루투스가 아닌 BLE로도 충분히 구현이 가능하지 않을까?**

</aside>

---

## BLE용어

### 1. **Central - Peripheral**

![](https://hackmd.io/_uploads/Sy3QIfFB3.png)


- Cetral[중앙장치]은 Peripheral[주변장치]에게 “나 데이터 원한다”
- Peripheral[주변장치]은 Cetral[중앙장치]에게 “응, 나 데이터 있음. 보내줄게~”

### 2. Advertisement(광고?)

![](https://hackmd.io/_uploads/S1gSUfYSh.png)


- 블루투스 선택화면에서 선택하라고 계속 알리고 있는 행위를 말하는 것 같음.
- 이는 peripheral[주변장치]이 다수의 Central[중앙장치]에게 송신할 수 있음. 
(ex. 블루투스 서칭하면 여러개 뜸)

### 3. GATT - 포괄적 특성 프로필

- BLE 장치 간 데이터를 **송-수신 하기 위한 프로토콜**
- **Service, Characteristic, Descriptor 3가지 개념을 사용**

**Characteristic - 특성**

- BLE 장치에서 데이터를 읽고 쓰기 위한 속성
- Characteristic은 UUID를 사용하여 구분
- Characteristic은 해당 데이터의 허용된 사용 방법을 나타내는 프로퍼티를 가짐
    - **READ**: Central이 Characteristic에서 데이터를 읽을 수 있음.
    - **Write**: Central이 Characteristic에서 데이터를 쓸 수 있음.
    - **Notify**: Peripheral이 Central에게 Characteristic의 데이터 변화를 알릴 수 있음.
- 데이터 타입(종류)과 데이터 값(실제 데이터)으로 구성

**Descriptor - 설명자**

- BLE 장치에서 Characteristic에 대한 **추가 정보 제공**
- Descriptor도 UUID를 사용하여 구분
- 일종의 주석 느낌
ex) 체중계 특성이라면 무게의 단위 정보를 제공 (kg/lb)

**Service - 서비스**

- BLE장치에서 제공하는 **기능 모음집**
- 여러 개의 Service를 가질 수 있으며, Service도 UUID를 사용하여 구분
- Service는 해당 Service에 속하는 여러 개의 Characteristic을 포함
ex1) 센서 데이터를 제공하는 Service
센서 데이터를 담은 여러개의 Characteristic을 포함할 수 있음.

**UUID - 범용 고유 식별자**

- Characteristic, Descriptor, Service 모두 UUID로 구분
- BLE에서 사용하는 UUID는 128-bit 길이의 값 (16진수 32개의 문자)
- 종류
    - 표준 UUID: Bluetooth SIG에서 제공하는 이미 정의된 UUID
        
        `웹사이트에서 UUID 목록 확인 가능함. 아래와 같이`
        
        ![](https://hackmd.io/_uploads/BJ6RIMYSn.png)

        
    - 사용자정의 UUID: 다른 디바이스와의 호환성을 고려하여 유니크한 값 사용 권장
    

---

## BLE 통신 시나리오 - (예시: 심박모니터 & 아이폰 상호작용)

<img src="https://hackmd.io/_uploads/rkLewGYr3.png" alt="image" height="500">


1. 아이폰이 스캔을 시작한다.
2. 심박 모니터가 Advertising 한다.
3. 아이폰은 연결요청을 받고, 연결을 함.

---

1. 심박수 Characteristic Notify를 구독함.
2. 심박수를 측정한다.
3. 심박계의 Characteristic 변화될 때마다 아이폰에게 데이터를 전달한다.
`(즉, Peripera이 Central에게 Characteristic의 데이터 변화를 알림)`
4. 아이폰이 심박수 데이터를 획득한다.

---

1. 아이폰이 심박모니터에게 연결해제요청을 보내고 연결 해제된다.

---

## CoreBluetooth `iOS 5.0 +`

### 1. Central Mode, Peripheral Mode (중앙장치모드, 주변기기모드)

**Central Mode (중앙장치모드) → 전반적으로 Periperal의 Service / Characteristic을 읽어내는 입장**

- **CBCentralManager**:
    - 다른 장치(Prepheral)을 검색, 연결 및 통신하는 객체
- **CBPeripheral**:
    - CBCentralManager를 통해 획득한 Peripheral 객체
    - 중앙장치를 통해 획득한 주변장치라고 보면 된다.(중앙장치로만 획득할 수 있음)

![](https://hackmd.io/_uploads/ryWlufYH3.png)


**PeriPheral Mode(주변장치모드) → 전반적으로 Service / Charicteristic을 생성하여 제공하는 입장**

- **CBPeriPheralManager**:
    - 다른 장치(Central)와 통신, Advertisement 하는 객체
- **CBCentral**:
    - Central 객체
    - 본인(PeriPheral)을 획득한 객체. 즉, Central 중앙장치를 말하는 객체

![](https://hackmd.io/_uploads/B1cZOGFrn.png)
