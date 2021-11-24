# LEDBoard

## UINavigationController
- 계층구조로 구성된 컨텐츠를 순차적으로 보여주는 container view
- Navigation Stack이라 칭하는 정렬된 배열을 사용하여 자식 ViewController 관리
- 기본적으로 LIFO(Last In First Out) 구조

## 화면 전환 방법
- ViewController의 View위에 다른 View를 가져와 바꿔치기
  * 메모리 누수의 위험이 있어 사용하지 않는 것이 좋음
- ViewController에서 다른 ViewController를 호출하여 바꿔치기
  * present method 파라미터에 이동하려는 ViewController를 넘겨줘 화면 전환
- NavigationController를 사용하여 화면 전환
  * NavigationController에서 push method 파라미터에 이동하려는 ViewController를 넘겨줘 화면 전환
- 화면 전환 객체(Segueway)를 사용하여 화면 전환
  * storyboard에서 ViewController끼리 Segueway 연결
  
## ViewController Life Cycle
- UIViewController의 객체에는 View계층을 관리하는 method들이 정의되어 있음
- 이 method들은 각자 자신들이 불려져야 하는 타이밍에 ios시스템에 의해 자동으로 호출
  * viewDidLoad : ViewController의 모든 View들이 메모리에 로드될때 딱 한번 호출
  * viewWillAppear : View가 View계층에 추가되고 화면에 보이기 직전에 매번 호출
  * viewDidAppear : View가 View계층에 추가되고 화면에 보인 직후에 매번 호출
  * viewWillDisappear : View가 View계층에서 사라지기 직전에 매번 호출
  * viewDidDisappear : View가 View계층에서 사라진 직후에 매번 호출
  
## 화면간 데이터 전달
- 코드로 구현된 화면 전환 방법에서 데이터 전달
  * instantiateViewController method를 이용하여 storyboard에 있는 ViewController가 instance화 되면 property에 접근하여 데이터 전달
- Segueway로 구현된 화면 전환 방법에서 데이터 전달
  * prepare method를 override하여 method안에서 전환하려는 ViewController의 instance를 가져온 뒤 property에 접근하여 데이터 전달
- Delegate 패턴을 이용하여 이전 화면으로 데이터 전달

## Assets Catalog
- 다양한 해상도에서 깨지지 않는 이미지를 표시하기 위해 다양한 크기의 이미지 리스트 추가
