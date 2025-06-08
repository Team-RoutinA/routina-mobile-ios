
<div align=center>

# 🍎 RoutinA_iOS 🍎

### This is the repository for *RoutinA-iOS*, created by Group 4 of the 2025-1 Mobile Programming class at Gachon University.  
#### 👉 [Group 4's Notion](https://www.notion.so/RoutinA-1d1f92702897800592d0cf7ec24f234d)

## 👶🏼 iOS Members 👶🏼
| <img src="https://avatars.githubusercontent.com/u/106726904?v=4" alt="Seulgi Lee" width="150"> | <img src="https://avatars.githubusercontent.com/u/106726862?v=4" alt="Jaehyeok Lee" width="150"> |
| :---: | :---: | 
| [Seulgi Lee](https://github.com/leeseulgi0208) | [Jaehyeok Lee](https://github.com/hamgui-2022) | 
| `Login Screens`<br/>`Alarm/Routine Create/Edit/Delete`<br/> `Custom Calendar` | `Splash Screen`<br/>`Routine Execution & Result Logging`<br/>`Achievement Feedback` |

</div>
<br/>

## 🛠️ Development Environment 🛠️
![iOS](https://img.shields.io/badge/iOS-000000?style=for-the-badge&logo=ios&logoColor=white)
![Xcode](https://img.shields.io/badge/Xcode-007ACC?style=for-the-badge&logo=Xcode&logoColor=white)

## 🥞 Stacks 🥞
| Name          | Description   |
| ------------  | ------------- |
| <img src="https://img.shields.io/badge/SwiftUI-524520?logo=swift"> | Apple’s declarative UI framework that enables efficient app development with concise syntax and state-driven UI. |
| <img src="https://img.shields.io/badge/-Git-F05032?style=flat&logo=git&logoColor=white"> | A distributed version control system used for managing code history and supporting team collaboration. |
| <img src="https://img.shields.io/badge/-Notion-000000?style=flat&logo=notion&logoColor=white"> | An integrated collaboration tool for managing tasks and documenting progress. |

## 📚 Libraries 📚
| Name         | Version  | Description        |
| ------------ |  :-----: |  ------------ |
| [Moya](https://github.com/Moya/Moya) | `15.0.3` | A network abstraction layer based on Alamofire that simplifies API requests. |
| [FSCalendar](https://github.com/WenchaoD/FSCalendar) | `2.8.4` | A highly customizable calendar library for iOS, supporting month views, multiple selections, and event indicators. |

## 💻 Convention 💻
### 🌲 Branch Convention 🌲
1. **Main Branches**
    - `main`: Stable code ready for production release
    - `develop`: Main development branch for feature integration

2. **Workflow**
    1. Create a GitHub Issue  
       e.g. `#111 Implement user login feature`

    2. Create a working branch  
        - Feature: `feature/#[issue-number]-title`  
          e.g. `feature/#111-login`  
        - Bug fix: `fix/#[issue-number]-title`  
          e.g. `fix/#111-login`  
        - Refactor: `refactor/#[issue-number]-title`  
          e.g. `refactor/#111-login`

    3. Work on your branch  
    4. Push to remote  
    5. Create a Pull Request to `develop`, get reviewed, then merge and delete the branch

---

### 🧑‍💻 Code Convention 🧑‍💻
We follow the **[StyleShare Swift Style Guide](https://github.com/StyleShare/swift-style-guide?tab=readme-ov-file#%EB%93%A4%EC%97%AC%EC%93%B0%EA%B8%B0-%EB%B0%8F-%EB%9D%84%EC%96%B4%EC%93%B0%EA%B8%B0)**.

**Naming Rules**
- **Variables/Constants**: camelCase (e.g. `userName`)
- **Classes/Structs**: PascalCase (e.g. `UserProfile`)
- **Functions/Methods**: Start with a verb, use camelCase (e.g. `fetchData()`)

**Code Style**
- Prefer explicit type declarations (e.g. `var name: String = "name"`)
- Use `guard` or `if let` to safely unwrap optionals
- Keep function parameters short and meaningful

---

### 💬 Issue Convention 💬
1. **Feature**
    - **Issue**: ✅ Feature
    - **Description**: Feature details
    - **TODO**:
        - [ ] Implementation tasks
    - **ETC**: Notes or things to discuss

2. **Fix/Bug**
    - **Issue**: 🐞 Fix / Bug
    - **Description**: Explain the bug
    - **Cause**: Root cause
    - **Solution**: Fix plan
    - **Result**: Confirmation
    - **ETC**: Any extra notes

3. **Refactor**
    - **Issue**: ♻️ Refactor
    - **Description**: What needs refactoring
    - **Before**: Current state & reason for change
    - **After**: Expected structure after change
    - **TODO**:
        - [ ] Refactoring tasks
    - **ETC**: Additional notes

---

### 🫷 PR Convention 🫸
```markdown
**🔗 Related Issue**

Mention related issue(s) (e.g. #123)

---

**📌 Summary**

A brief summary of the PR and its purpose.

---

**📑 Details**

List the detailed work done:

1. Task 1
2. Task 2
3. Task 3

---

**📷 Screenshot (optional)**

---

**💡 Additional Notes**

Mention any testing methods, edge cases, or impacts on the codebase.
```

---

### 🙏 Commit Convention 🙏

- `feat`: Add a new feature  
- `fix`: Fix a bug  
- `docs`: Documentation changes only  
- `style`: Code formatting or styling (e.g. spacing)  
- `refactor`: Refactor code without changing behavior  
- `design`: UI-related design updates  

```swift
// Format
[[Type]/#[Issue Number]]: [Description]

// Example
[feat/#1]: Implement login feature
[fix/#32]: Fix login API error
```

---

### 📁 Foldering Convention 📁
```markdown
📦routina-mobile-ios
┣ 📂App                   # Main app entry views (AppDelegate, RootView, etc.)
┃ ┣ 📂Component           # Reusable UI components (buttons, layouts, etc.)
┃ ┣ 📂Do                  # Views and logic related to routine execution
┃ ┣ 📂Login               # Authentication-related views and state
┃ ┣ 📂Plan                # Routine creation/editing screens
┃ ┣ 📂See                 # Stats and feedback screens
┃ ┣ 📂Utils               # Global utilities and constants
┃ ┣ 📄AppDelegate.swift   # App lifecycle handling
┃ ┣ 📄RootView.swift      # Main root view after login
┃ ┣ 📄SplashView.swift    # Splash screen shown on launch
┃ ┗ 📄WelcomeView.swift   # Onboarding and login entry view
┣ 📂Fonts                 # Custom font files and configuration
┣ 📂Helper                # ViewModels, extensions, and utility logic
┣ 📂Network               # Moya-based API layer, DTOs, and networking
┗ 📂Resources             # Assets like images, sounds, etc.
```
