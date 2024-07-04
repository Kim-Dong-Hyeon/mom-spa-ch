# MomSpaCh Project

### 역할 분담

| 이름 | 역할 |
|:---:|:---|
| 조수환 | Launch Screen & 메인 페이지 & Asset 담당 & 깃허브 담당 |
| 김동현 | 상단 메뉴 카테고리 바 |
| 김윤홍 | 메뉴 화면 |
| 백시훈 | 주문 내역 화면 |
| 최건 | 취소하기 / 결제하기 버튼 화면 |

💡 **들어가기 전에! (주의사항)**

1. **CodeBase UI로 구현하기**
    1. 이번 프로젝트는 로직 구현보다는 UI 구현에 대해서 좀 더 많은 학습과 시도를 요하는 프로젝트입니다! 
    2. **첫 협업 프로젝트에서부터 코드베이스 UI를 시도해봅니다.** 
    3. 이번 프로젝트에서 코드로 UI짜는 연습을 집중적으로 해야 이후 프로젝트에 더 도움이 됩니다. 어려워도 괜찮아요~! 팀원들과 함께, 튜터님들과 함께 진행해봅시다. 
2. **iOS 버전 설정**
    1. 현재 프로젝트를 생성하면 iOS 17.x로 프로젝트가 생성
    2. iOS 15로 정해두고 개발하기
        1. 왜? 최신의 애플 버전의 경우 실제 구글링 자료도 적고, 버그들도 종종 존재하는 편이라, 최신의 버전 사용보다는 이미 검증받은 버전 위주로 사용하는 것이 학습에는 도움이 됩니다.
        2. 보통 최신버전의 2버전 전을 타겟으로 하는 경우가 많아 `iOS 15`로 정해두고 개발하기🔥
        
3. **데이터**
    1. 각 화면에 어떤 데이터들이 보여지고 있는지 생각해보세요.
    모바일에서는 작은 화면에서 어떤 데이터를 보여주는지에 따라서 기획부터 디자인, 개발까지 많은 차이가 생깁니다.
        1. 설계된 와이어 프레임에 들어가는 데이터의 타입 및 이름(변수명)을 설정해보세요.
4. **“merge-conflict 주의”**
    1. “저 건든 거 없는데 Merge Conflict가 나요!” 는 금물! Xcode를 실행만 시켜도 변경되는 사항이 있을 수 있습니다!
    - 해결 방법
        1. **우리 팀의 규칙을 만들기**
            1. 간단한 view의 이동이나 속성 변경이 파일의 큰 변경을 불러올 수 있습니다.
            2. 동시에 같은 코드를 수정하지 말자는 규칙을 정합시다.
        2. **Git을 활용해 빈번하게 변경사항 커밋하기.**
            1. 큰 덩어리의 코드에서 에러가 나면 해결하기 쉽지 않아요.
            2. 소통을 자주하며 어느정도 완성되었다면 커밋해서 코드를 합치는 작업을 진행합니다.
            3. 중요한 변경 사항이 포함된 병합을 시도하기 전에 예비 브랜치를 미리 만들어두세요! 
            혹시 모르죠! 잘못될 경우를 대비한 안전장치를 마련해둡시다.
        3. **병합할 때는 관련 기능을 만든 사람 모두가 참석한다.**
            1. 병합할 때 Xcode가 파일에서 충돌을 감지하면 이를 해결하라는 메시지가 표시
            2. Xcode에서 파일을 열면 충돌 마커("<<<<", "====" 및 ">>>>")로 표시된 섹션이 표시
            3. 충돌하는 섹션을 팀원들과 함께 논의하여 검토하고 편집하기
            4. 일방적으로 팀원 혹은 팀장이 해결하지 않기
5. **생각해볼 것**
    1. 이번 프로젝트는 하나의 ViewController만을 이용하고 화면전환이 이루어지지 않는 프로젝트입니다. 한 화면에 어떻게 View를 구성하고 배치할지 고민해봅시다.
    2. 만약 이를 하나의 ViewController 내에서 모든 로직을 처리했다면 구현이 가능했을지, 협업이 가능했을지를 생각해보면서 컴포넌트별로 나누어서 작업하는 것의 장단점을 생각해봅시다.
        1. ViewController 안에 모든 UI와 로직을 구현하는 것 보다 각각의 역할(커스텀 View나 비즈니스 로직)을 담당하는 클래스를 구현하는 방향으로 설계하여 구현해보세요!

### 필수 구현 기능

- [ ]  메인 페이지
    - [ ]  키오스크 화면을 보여주는 페이지 구성
    - [ ]  키오스크 화면 자체가 하나의 ViewController
        - [ ]  아래의 각 부분을 UI 컴포넌트로 잘 분리하기
    
- [ ]  상단 메뉴 카테고리 바
    - [ ]  메뉴 카테고리(ex. 추천메뉴, 햄버거, 디저트/치킨 등)를 정의하고 메뉴 구성
    - [ ]  `UISegmentedControl` *,* `UIStackView` , `UICollectionView` 등을 활용하여 화면을 구성
    
- [ ]  메뉴 화면
    - [ ]  특정 메뉴 카테고리 클릭 시, 메뉴 카테고리에 해당하는 메뉴들을 표시
    - [ ]  `UICollectionView` 등을 활용하여 화면을 구성
    
- [ ]  주문 내역 화면
    - [ ]  총 주문 메뉴 개수를 “총 주문내역 X개” 로 표시해주세요
    - [ ]  주문한 메뉴들이 표시될 수 있도록 구성해주세요
        - [ ]  각 메뉴를 표시하면서 각 메뉴 옆에 `+`, `-`버튼을 만들어서 해당 메뉴의 수량을 조정
    - [ ]  `UITableView` 등을 활용하여 화면을 구성해보세요

- [ ]  취소하기 / 결제하기 버튼 화면
    - [ ]  주문 메뉴 전체를 취소하는 취소하기 버튼을 구현
    - [ ]  주문 메뉴 전체를 결제하는 결제하기 버튼을 구현

### 추가 구현 기능 (선택)

💡 **반드시 해내야만 하는 기능이 아닙니다.**

- 기본적으로 이번 프로젝트에서는 UI 구현에 집중해주시고, 팀에 따라 선택적으로 진행하는 선택 과제입니다.
- [ ]  부가 기능 추가
    - ex. `돋보기` 와 같은 부가적인 기능 구현
    - ex. 오늘의 제일 잘 팔린 메뉴 보기
    - ex. 직원호출 → alert창 띄우기
    
- [ ]  다크 모드 구현
    - [ ]  다크 모드 기능을 위 “부가 기능 추가”의 기능으로 추가
    - [ ]  라이트 모드 ↔ 다크 모드 전환이 가능하도록 Color를 설정
    - [ ]  Appearance 설정에 대해 알아봅니다.
    - [ ]  System Color를 활용하거나, Color Assets를 활용하여 커스텀 컬러 설정 시에도 다크 모드 대응
    
- [ ]  페이징 기능
    - [ ]  최대로 표현할수 있는 메뉴 수가 넘었을 때 좌우로 `이전` , `다음` 버튼을 만들어서 한 페이지당 표현할수 있는 메뉴의 개수를 맞춰주세요.
        - 하단에 빨간 점을 보실 수 있는데, 현재 페이지는 빨간 점, 다른 페이지는 회색 점으로 그려주세요.

![스크린샷 2023-12-23 오후 11.20.32.png](https://teamsparta.notion.site/image/https%3A%2F%2Fprod-files-secure.s3.us-west-2.amazonaws.com%2F83c75a39-3aba-4ba4-a792-7aefe4b07895%2F56d9466c-bb08-4f03-b640-4ed113989b54%2F%25E1%2584%2589%25E1%2585%25B3%25E1%2584%258F%25E1%2585%25B3%25E1%2584%2585%25E1%2585%25B5%25E1%2586%25AB%25E1%2584%2589%25E1%2585%25A3%25E1%2586%25BA_2023-12-23_%25E1%2584%258B%25E1%2585%25A9%25E1%2584%2592%25E1%2585%25AE_11.20.32.png?table=block&id=8ee43094-552c-4067-87b1-e5429f31fad6&spaceId=83c75a39-3aba-4ba4-a792-7aefe4b07895&width=1050&userId=&cache=v2)


💡 **협업을 위한 방법** 💑

1. 우리 팀이 만들 서비스 기획에 대한 충분한 논의.
    
   > ❓ 우리 팀은 이번에 어떤 서비스를 만들어보면 좋을까요?<br>
   > 우리 팀은 어떤 기능들을 구현해볼까요?<br>
   > 각 기능은 누가 맡아서 진행할까요?<br>
   > 마감 기한은 어떻게 정할까요? 배포 시기는 언제로 할까요?
    
2. 결과물에 대한 목업(MOCKUP) 그려보기
    - 주요 색상 혹은 프레임 디자인 등 
    (스파르타코딩클럽 스타일, Google 스타일, NAVER 스타일 등)
    - PPT, 피그마 등 자유롭게 도구를 활용해주세요. (툴 사용법 숙지에 너무 시간을 들이지 않기!)
3. 목업을 기반한 화면에 관한 논의
    1. 메인 페이지
    2. 상단 메뉴 카테고리 바
    3. 메뉴 화면
    4. 주문 내역 화면
    5. 취소하기 / 결제하기 버튼 화면
4. 기술 개발 및 결합 과정의 방법 논의
    - 내용
        - 브랜치를 어떻게 나누고 어떻게 병합할 것인지
        - 어느 시점에 브랜치 병합을 할 것인지
        - 일반적으로 브랜치를 이렇게 나눠요
            - 마스터 브랜치(master) - 배포용
            - 디벨롭 브랜치(dev)
            - 기능 단위 별 브랜치
        - 병합 순서는 대체로 이렇게 진행해요.
            - 기능 단위 별 브랜치 — 병합 → 디벨롭 브랜치 — 최종병합→ 마스터 브랜치
5. **개발 진행에 따른 기록 작성(★★★★★)**
    - 개발 혹은 개발을 위한 공부를 진행 할 때마다 간략한 글 작성하기
    ( ※ 티스토리, velog, 카카오 브런치, 네이버 블로그 등 불특정 다수가 확인 가능한 소셜 플랫폼 활용)
        1. 어떠한 이유로 해당 `기능`을 사용하였는지
            
            ※ 튜터님께, 강의에서 배웠습니다. 라는 이유는 피해주세요.
            
            ※ 각 기술의 장단점을 알고, 지금 상황에서 최고, 최선의 선택이었다는 점을 어필하게 될거에요.
            
        2. 해당 기능의 `코드`는 어떠한 `로직`을 가지고 있는지
            
            ※ 입력값이 들어가면 어떠한 코드를 통해 어떠한 값으로 변화하는지
            
        3. `코드`를 작성하며 발견된 `버그`나 `오류`는 어떠한게 있었는지 그리고 어떻게 해결하였는지.
