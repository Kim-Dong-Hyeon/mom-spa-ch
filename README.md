<img src="https://i.ibb.co/CssZsmG/App-Icon-ios-marketing.png" alt="App-Icon-ios-marketing" width="30%">

# MomSpaCh Project
</p>

### 역할 분담

| 이름 | 역할 |
|:---:|:---|
| 조수환 | Asset페이지, LaunchScreen, 더치페이 기능 구현 |
| 김동현 | 프로젝트 일정관리, SA작성, 와이어프레임 작성, 상단 메뉴 카테고리바, 검색 창 |
| 김윤홍 | Model구현, collectionView, pageControl, MVC구현 |
| 백시훈 | 주문내역 화면 구현 |
| 최건 | 취소하기, 주문하기, 다크모드, gesture로 segementControl이동 구현 |

### Ground Rule
> - 브랜치는 main 브랜치와 각자 이니셜로 된 브랜치를 생성하여 자신의 브랜치에서 작업한다.
> - [추가] develop 브랜치를 생성하여 개인 브랜치에서 develop 브랜치로 Pull requests 를 한다.
>     - main 브랜치에 바로 Push & Pull requests 를 하는 것은 위험하므로 develop 브랜치가 Merge Conflict가 날 경우에도 완충장치 역할을 한다
> - 매일 정해진 시간(저녁 스크럼)에 Pull Request를 진행한다.
>     - 예외의 경우 팀원들과 협의한 후 함께 진행한다.
> - 깃 Pull Request시에 팀원 모두가 참여하여 지켜보는 가운데 Merge를 진행한다.
>     - Conflict가 날 경우 해당 코드를 작성한 사람과 협의 후에 코드 수정을 진행한다.
>     - 모두가 참여할 수 없을 경우에는 해당 코드를 작성한 담당자 만이라도 필수 참여한다.
> - Code Review는 다같이 한다.
> - CodeConvention과 CommitConvention을 잘 지킨다.

### 필수 구현 기능

- [x]  메인 페이지
    - [x]  키오스크 화면을 보여주는 페이지 구성
    - [x]  키오스크 화면 자체가 하나의 ViewController
        - [x]  아래의 각 부분을 UI 컴포넌트로 잘 분리하기
    
- [x]  상단 메뉴 카테고리 바
    - [x]  메뉴 카테고리(ex. 추천메뉴, 햄버거, 디저트/치킨 등)를 정의하고 메뉴 구성
    - [x]  `UISegmentedControl` *,* `UIStackView` , `UICollectionView` 등을 활용하여 화면을 구성
    
- [x]  메뉴 화면
    - [x]  특정 메뉴 카테고리 클릭 시, 메뉴 카테고리에 해당하는 메뉴들을 표시
    - [x]  `UICollectionView` 등을 활용하여 화면을 구성
    
- [x]  주문 내역 화면
    - [x]  총 주문 메뉴 개수를 “총 주문내역 X개” 로 표시해주세요
    - [x]  주문한 메뉴들이 표시될 수 있도록 구성해주세요
        - [x]  각 메뉴를 표시하면서 각 메뉴 옆에 `+`, `-`버튼을 만들어서 해당 메뉴의 수량을 조정
    - [x]  `UITableView` 등을 활용하여 화면을 구성해보세요

- [x]  취소하기 / 결제하기 버튼 화면
    - [x]  주문 메뉴 전체를 취소하는 취소하기 버튼을 구현
    - [x]  주문 메뉴 전체를 결제하는 결제하기 버튼을 구현

### 추가 구현 기능 (선택)

- [x] 다크 모드 구현
    - [x]  라이트 모드 ↔ 다크 모드 전환이 가능하도록 Color를 설정
    - [x]  Color Assets를 활용하여 커스텀 컬러 설정 시에도 다크 모드 대응
    
- [x] 검색 기능 구현
    - [x]  TextField에 사용자가 입력한 값을 바탕으로 메뉴 정보 표시
    - [x]  입력 값을 지울 수 있는 × 버튼 추가
    
- [x] 페이징 기능 구현
    - [x]  최대로 표현할수 있는 메뉴 수가 넘었을 때 좌우로 `이전` , `다음` 버튼을 만들어서 한 페이지당 표현할수 있는 메뉴의 개수를 맞춰주세요.
        - 하단에 빨간 점을 보실 수 있는데, 현재 페이지는 빨간 점, 다른 페이지는 회색 점으로 그려주세요.
    - [x]  검색된 정보 페이징 구현

        <img src="https://teamsparta.notion.site/image/https%3A%2F%2Fprod-files-secure.s3.us-west-2.amazonaws.com%2F83c75a39-3aba-4ba4-a792-7aefe4b07895%2F56d9466c-bb08-4f03-b640-4ed113989b54%2F%25E1%2584%2589%25E1%2585%25B3%25E1%2584%258F%25E1%2585%25B3%25E1%2584%2585%25E1%2585%25B5%25E1%2586%25AB%25E1%2584%2589%25E1%2585%25A3%25E1%2586%25BA_2023-12-23_%25E1%2584%258B%25E1%2585%25A9%25E1%2584%2592%25E1%2585%25AE_11.20.32.png?table=block&id=8ee43094-552c-4067-87b1-e5429f31fad6&spaceId=83c75a39-3aba-4ba4-a792-7aefe4b07895&width=1050&userId=&cache=v2" alt="img" width="70%">
    
- [x] 스와이프 기능 구현
    - [x]  스와이프 제스처를 통한 카테고리 이동 가능
    - [x]  상단의 카테고리 선택이 한 손 조작이 어려울 경우를 위해 스와이프 기능 추가
    
- [x] 주문 내역 갱신 효과 구현
    - [x] 메뉴 추가 시 주문 내역 목록 크기를 벗어나는 경우 스크롤을 아래로 내려주는 효과 구현
    
- [x] 더치페이 기능 구현
    - [x]  더치페이 할 인원 수를 버튼을 통해 증감시켜 1인당 지불해야 할 금액을 표시
    
- [x] 결제 Alert 추가
    - [x]  결제하기 버튼 클릭 시 주문 내역에 따른 Alert 구현
        - 주문 내역 없을 경우 : "주문 내역을 확인해 주십시오" Alert 구현
        - 주문 내역 있을 경우 : "최종 결제 금액 00000원 입니다. 주문하시겠습니까?" 확인/취소 Alert 구현
    - [x]  주문 시 "주문 완료되었습니다." Alert 구현

<br>

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
