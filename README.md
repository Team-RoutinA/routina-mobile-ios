<div align=center>

# 🍎 RoutinA_iOS 🍎

### 가천대학교 2025-1 모바일프로그래밍 4조 RoutinA-iOS 레포지토리입니다.
#### [4조 노션 링크](https://www.notion.so/RoutinA-1d1f92702897800592d0cf7ec24f234d)

## 👶🏼 iOS Members 👶🏼
| <img src="https://avatars.githubusercontent.com/u/106726904?v=4" alt="이슬기 프로필" width="150"> | <img src="https://avatars.githubusercontent.com/u/106726862?v=4" alt="이재혁 프로필" width="150"> |
| :---: | :---: | 
| [이슬기](https://github.com/leeseulgi0208) | [이재혁](https://github.com/hamgui-2022) | 
| `로그인 화면`<br/>`알람/루틴 생성/수정/삭제 화면`<br/> `캘린더 커스텀` | `스플래쉬 화면`<br/>`알람/루틴 실행, 결과 기록 화면`<br/>`달성률 피드백 화면` | 
</div>
<br/>

## 🛠️ Development Environment 🛠️
![iOS](https://img.shields.io/badge/iOS-000000?style=for-the-badge&logo=ios&logoColor=white)
![Xcode](https://img.shields.io/badge/Xcode-007ACC?style=for-the-badge&logo=Xcode&logoColor=white)

## 🥞 Stacks 🥞
| Name          | Description   |
| ------------  | ------------- |
| <img src="https://img.shields.io/badge/SwiftUI-524520?logo=swift"> | 애플이 만든 선언형 UI 프레임워크로, 간결한 문법과 상태 기반 UI 구성 방식으로 iOS 앱을 효율적으로 개발할 수 있다.|
| <img src="https://img.shields.io/badge/-Git-F05032?style=flat&logo=git&logoColor=white"> | 분산 버전 관리 시스템으로, 코드 히스토리 관리와 협업을 효율적으로 지원한다.|
| <img src="https://img.shields.io/badge/-Notion-000000?style=flat&logo=notion&logoColor=white"> | 작업 관리 및 문서화를 위한 통합 협업 도구.|

## 📚 Libraries 📚
| Name         | Version  |  Description        |
| ------------ |  :-----: |  ------------ |
| [Moya](https://github.com/Moya/Moya) |  `15.0.3`  | 네트워크 요청을 관리하는 데 도움을 주는 Alamofire 기반의 네트워크 추상화 라이브러리.|
| [FSCalendar](https://github.com/WenchaoD/FSCalendar) |  `2.8.4`  | 커스터마이징이 쉬운 iOS용 캘린더 라이브러리로, 월간 달력 뷰를 손쉽게 구현할 수 있으며, 다양한 날짜 선택 및 이벤트 표시 기능을 제공.|


## 💻 Convention 💻
### 🌲 Branch Convention 🌲
1. **기본 브랜치 설정**
    - main : 배포 가능한 안정적인 코드가 유지되는 브랜치
    - develop: 기본 브랜치로, 기능을 개발하는 브랜치
2. **작업 순서**
    
    1. 작업할 이슈 작성
    
    예) `#111 사용자 로그인 기능 구현`
    
    2. 작업 브랜치 생성
        - 기능 개발: `feature/#[이슈번호]-title`
            - ex) feature/#111-login
        - 버그 수정: `fix/#[이슈번호]-title`
            - ex) fix/#111-login
        - 리팩토링: `refactor/#[이슈번호]-title`
            - ex) refactor/#111-login
    3. **생성한 브랜치에서 작업 수행** 
    4. **원격 저장소에 작업 브랜치 푸시** 
    5. **Pull Request 생성**
    - `develop` 브랜치 대상으로 Pull Request 생성
    - 리뷰어의 리뷰를 받은 후 PR을 승인 받고 `develop` 브랜치에 병합 후 브랜치 삭제
---
### 🧑‍💻 Code Convention 🧑‍💻
**저희는 Swift Style Guide을 따릅니다.**

[StyleShare](https://github.com/StyleShare/swift-style-guide?tab=readme-ov-file#%EB%93%A4%EC%97%AC%EC%93%B0%EA%B8%B0-%EB%B0%8F-%EB%9D%84%EC%96%B4%EC%93%B0%EA%B8%B0)

**네이밍 규칙**

- **변수/상수**: 카멜케이스 (예: `userName`)
- **클래스/구조체**: 파스칼케이스 (예: `UserProfile`)
- **함수/메서드**: 동사로 시작하며 카멜케이스 (예: `fetchData()`)

 **코드 스타일**

- **명시적 타입 선언**: 가능하면 타입 명시 (예: `var name : String = “name”`)
- **옵셔널 처리**: `guard`나 `if let`을 사용하여 안전하게 언래핑
- **함수 파라미터**: 간결하고 직관적인 이름 사용
---
### 💬 Issue Convention 💬
1. **Feature**: 기능 추가 시 작성
    - **Issue**: ✅ Feature
    - **내용**: 작업하고자 하는 기능을 입력
    - **TODO**:
        - [ ]  구현 내용 입력
    - **ETC**: 논의가 필요한 사항이나 참고 내용 작성
2. **Fix/Bug**: 오류/버그 발생 시 작성
    - **Issue**: 🐞 Fix / Bug
    - **내용**: 발생한 문제 설명
    - **원인 파악**
    - **해결 방안**
    - **결과 확인**
    - **ETC**: 논의할 사항 작성
3. **Refactor**: 리팩토링 작업 시 작성
    - **Issue**: ♻️ Refactor
    - **내용**: 리팩토링이 필요한 부분 작성
    - **Before**: 변경 전 상태 및 이유 설명
    - **After**: 변경 후 예상되는 구조 설명
    - **TODO**:
        - [ ]  변경 내용 입력
    - **ETC**: 논의할 사항 작성
---
### 🫷 PR Convention 🫸
```markdown
**🔗 관련 이슈**

연관된 이슈 번호를 적어주세요. (예: #123)

---

**📌 PR 요약**

PR에 대한 간략한 설명을 작성해주세요.

(예: 해당 변경 사항의 목적이나 주요 내용)

---

**📑 작업 내용**

작업의 세부 내용을 작성해주세요.

1. 작업 내용 1
2. 작업 내용 2
3. 작업 내용 3

---

**스크린샷 (선택)**

---

**💡 추가 참고 사항**

PR에 대해 추가적으로 논의하거나 참고해야 할 내용을 작성해주세요. (예: 변경사항이 코드베이스에 미치는 영향, 테스트 방법 등)
```
---
### 🙏 Commit Convention 🙏

- `feat` : 새로운 기능이 추가되는 경우
- `fix` : bug가 수정되는 경우
- `docs` :  문서에 변경 사항이 있는 경우
- `style` : 코드 스타일 변경하는 경우 (공백 제거 등)
- `refactor` : 코드 리팩토링하는 경우 (기능 변경 없이 구조 개선)
- `design` : UI 디자인을 변경하는 경우

```swift
// Format
[[Type]/#[이슈 번호]]: [Description]

// Example
[feat/#1]: 로그인 기능 구현
[fix/#32]: 로그인 api 오류 수정
```
---
### 📁 Foldering Convention 📁
```markdown
📦routina-mobile-ios
┣ 📂App                   # 앱의 주요 View 파일과 진입점 관리 (AppDelegate, RootView 등)
┃ ┣ 📂Component           # 공통 컴포넌트 (버튼, 뷰 등 재사용 가능한 UI 요소)
┃ ┣ 📂Do                  # 루틴 실행 관련 뷰 및 로직
┃ ┣ 📂Login               # 로그인/회원가입 관련 뷰 및 상태 관리
┃ ┣ 📂Plan                # 루틴 생성 및 편집 관련 화면
┃ ┣ 📂See                 # 통계/피드백 확인 화면
┃ ┣ 📂Utils               # 앱 전역 유틸리티 함수, 상수 등
┃ ┣ 📄AppDelegate.swift   # 앱의 라이프사이클 관리
┃ ┣ 📄RootView.swift      # 로그인 후 진입하는 루트 탭뷰
┃ ┣ 📄SplashView.swift    # 앱 실행 시 보여지는 스플래시 화면
┃ ┗ 📄WelcomeView.swift   # 온보딩 및 로그인 진입 화면
┣ 📂Fonts                 # 커스텀 폰트 파일 및 관련 설정
┣ 📂Helper                # ViewModel, Extension 등 보조 로직
┣ 📂Network               # Moya 기반 API, DTO, 통신 설정
┗ 📂Resources             # 이미지, 사운드 등 앱 리소스 파일
```
