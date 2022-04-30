# TodoList

## UITableView
  - 데이터를 목록형태로 보여줄 수 있는 가장 기본적인 UI컴포넌트
  - 여러개의 셀을 가지고 있고 하나의 열과 여러줄의 행을 가지고 있음
  - 수직으로만 스크롤이 가능
  - 섹션을 이용해 행을 그룹화 하여 컨텐츠를 좀 더 쉽게 탐색할 수 있음
  - 섹션의 Header와 Footer에 View를 구성하여 추가적인 정보를 표시할 수 있음
  - Datasource: 데이터를 받아 View를 그려주는 역할
    * numberOfRowsInSection: 각 섹션에 표시할 행의 개수를 설정하는 메서드
    * cellForRowAt: 특정 인덱스 row의 cell에 대한 정보를 넣어 cell을 변환하는 메서드
    * numberOfSection: 총 섹션 개수를 설정하는 메서드
    * titleForHeaderInSection: 특정 섹션의 Header 타이틀을 설정하는 메서드
    * titleForFooterInSection: 특정 섹션의 Footer 타이틀을 설정하는 메서드
    * canEditRowAt: 특정 위치의 행이 수정가능한지 설정하는 메서드
    * canMoveRowAt: 특정 위치의 행을 재정렬 할 수 있는지 설정하는 메서드
    * sectionIndexTitles: 테이블 뷰 섹션 인덱스 타이틀을 불러오는 메서드
    * sectionForSectionIndexTitle: 인덱스에 해당하는 섹션을 알려주는 메서드
    * commitForRowAt: 스와이프 모드, 편집모드에서 버튼을 선택하면 호출되는 메서드
    * moveRowAt: 행이 다른 위치로 이동되면 어디에서 어디로 이동되는지 알려주는 메서드
  - Delegate: 테이블 뷰의 동작과 외관을 담당
    * didSelectRowAt: 행이 선택되었을 때 호출되는 메서드
    * dldDeselectRowAt: 행이 선택해제되었을 때 호출되는 메서드
    * heightForRowAt: 특정 위치 행의 높이를 설정하는 메서드
    * viewForHeaderInSection: 지정된 섹션의 Header 뷰에 표시되는 뷰가 어떤것인지 설정하는 메서드
    * viewForFooterInSection: 지정된 섹션의 Footer 뷰에 표시되는 뷰가 어떤것인지 설정하는 메서드
    * heightForHeaderInSection: 지정된 섹션의 Header 뷰의 높이를 설정하는 메서드
    * heightForFooterInSection: 지정된 섹션의 Footer 뷰의 높이를 설정하는 메서드
    * willBeginEditingRowAt: 테이블 뷰가 편집모드에 들어갔을 때 호출되는 메서드
    * didEndEditingRowAt: 테이블 뷰가 편집모드에서 빠져나왔을 때 호출되는 메서드
    * willDisplay: 테이블 뷰가 셀을 사용하여 행을 그리기 직전에 호출되는 메서드
    * didEndDisplaying: 테이블 뷰로부터 셀이 사라지면 호출되는 메서드
    
## UIAlertViewController
  - 알림창을 구성하고 AlertViewController를 present하여 알림창이 앱에 표시되도록 해줌
  
## UserDefaults
  - 런타임 환경에서 동작하면서 앱이 실행되는 동안 기본 저장소에 데이터를 저장하고 가져오는 역할
  - 로컬에 등록한 데이터를 저장하고 앱을 재실행 했을 때 데이터를 불러옴
  
## selector 타입
  - selector 타입으로 전달할 메서드를 작성할 경우 obj-c와의 호환성을 위해 @objc 어트리뷰트를 작성
