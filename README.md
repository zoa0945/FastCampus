# 명언 생성기

## UIKit
- 사용자 인터페이스 관리, 이벤트 처리
- App을 구성하는 많은 요소들이 UIKit 프레임워크에 포함
  
## UIView
- 화면을 구성하는 요소의 기본 클래스
- 여러 UI컴포넌트들이 UIView를 상속받고 있음
  
## UIViewController
- 앱의 근간을 이루는 객체
- 데이터의 변화에 따라 View Contents들을 업데이트
- View들과 함께 사용자 상호작용에 응답
- 전체적인 인터페이스의 레이아웃 관리
- 다른 ViewController와 함께 앱을 구성
- 화면 하나를 관리하는 단위
  
## AutoLayout
- 아이폰의 다양한 해상도 비율에 대응하기 위한 요소
- 제약조건을 이용해 뷰의 위치나 크기를 지정하는 요소
  
## IBOutlet & IBAction
- IBOutlet : 스토리보드에 등록한 UI Object를 코드에서 변수로 접근하게 할수 있도록 함
- IBAction : 버튼과 연결해 이벤트를 처리하는 함수를 만들어 줌
  
## Priority
- 텍스트나 이미지에 따라 크기가 결정되는 뷰가 다른 뷰들과의 제약에 의해 본래의 사이즈보다 늘어나거나 줄어들때 우선순위 지정
- hugging priority : 사이즈가 늘어나는 것에 대해 저항하는 제약
- compression resistence : 사이즈가 줄어드는 것에 대해 저항하는 제약
- 우선순위가 높으면 컨텐츠 사이즈 유지
