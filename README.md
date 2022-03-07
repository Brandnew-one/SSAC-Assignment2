
<img width="1685" alt="스크린샷 2022-03-01 오후 10 35 36" src="https://user-images.githubusercontent.com/88618825/156178788-1e95afd7-1597-4c7e-876d-9fce5aa2a204.png">

## 🔥 앱 소개

> 회원가입을 진행한 유저들과 게시글 및 댓글을 통해서 의사소통 할 수 있는 커뮤니티 앱입니다.

* 시작화면에서 회원가입 또는 로그인을 진행할 수 있습니다. 
* 최신순으로 사용자들이 작성한 게시글을 확인할 수 있습니다.
* 자신이 작성한 게시글이나 댓글의 경우 수정, 삭제를 진행할 수 있습니다.

| 시작화면 | 게시글 | 댓글 | 댓글 수정 |
| - | - | - | - |
| ![Simulator Screen Shot - iPhone 13 Pro - 2022-03-01 at 21 49 24](https://user-images.githubusercontent.com/88618825/156179604-9b39e10d-dd7a-45ed-99b8-dd57ee8bb9c5.png) | ![Simulator Screen Shot - iPhone 13 Pro - 2022-03-01 at 21 50 03](https://user-images.githubusercontent.com/88618825/156179648-dc9c9805-e4e6-4472-b132-50c4852ef28a.png) | ![Simulator Screen Shot - iPhone 13 Pro - 2022-03-01 at 21 50 14](https://user-images.githubusercontent.com/88618825/156179691-09f54531-73ab-43c5-ac55-22217d62fb09.png) | ![Simulator Screen Shot - iPhone 13 Pro - 2022-03-01 at 21 51 00](https://user-images.githubusercontent.com/88618825/156181045-b7a0daaa-6415-4d1d-898c-d4ee8bdcb361.png) |

<br>

## 📆 개발기간

#### 22.01.04 ~ 22.01.12

<br>

## 🏷 사용기술

* Swift, UIKit, SnapKit
> StoryBoard 를 사용하지 않고, Snapkit 을 이용해 Code-Based UI 를 사용했습니다.

* Codable, URLSession
> URLSession 을 통해 API를 이용한 CRUD를 구현했습니다.

* MVVM
> MVVM 패턴 적용을 통해 뷰모델이 재활용 될 수 있도록 노력했습니다.

* RxCocoa
> 학습차원에서 회원가입 뷰에 Rx 를 적용시켰습니다.

<br>

***

## 😤 회고

처음으로 `MVVM패턴`, `CodeBased-UI` 를 적용시켰다. 지금까지 StoryBoard로 레이아웃을 잡는게 편했는데 확실히 이번 프로젝트를 하면서 코드로 레이아웃을 잡는게 익숙해졌고 오히려 편해졌다.

MVVM 패턴은 여전히 더 공부해야 하지만 최대한 재사용 가능한 View, ViewModel을 만들어서 코드 중복을 줄일 수 있는 방향으로 설계해야 함을 깨달았다. 


## 📱 시연영상

| 시작화면  | 회원가입  | 
| --- | --- |
| ![시작화면](https://user-images.githubusercontent.com/88618825/152643125-128fd1b9-0c4c-4cef-a5de-e38e288477c2.gif)  | ![회원가입](https://user-images.githubusercontent.com/88618825/152643158-3a04600b-a7fc-434b-a175-06aec8e36c41.gif)  |  

| 게시판 및 댓그 작성  | 게시글 작성 및 수정  | 
| --- | --- |
| ![ 보드](https://user-images.githubusercontent.com/88618825/152643201-c15ff236-4d6f-45eb-a609-3ebc2016dc80.gif)  | ![게시글 작성](https://user-images.githubusercontent.com/88618825/152643589-3d45ff03-9c9c-4673-bfef-b36bf5896800.gif) |

