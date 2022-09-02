//
//  ViewController.swift
//  QuotesGenerator
//
//  Created by Mac on 2021/11/16.
//

/*
 UIKit
 - 사용자 인터페이스를 관리하고 이벤트를 처리하는게 주 목적
 - 어플리케이션을 구성하는 많은 요소들이 UIKit Framework에 포함
 
 UIView
 - 화면을 구성하는 요소의 기본 클래스
 - 여러 UI컴포넌트들이 UIView를 상속받고 있음
 
 UIViewController
 - 앱의 근간을 이루는 객체
 - 데이터의 변화에 따라 View Contents들을 업데이트 함
 - View들과 함께 사용자 상호작용에 응답을 함
 - 전체적인 인터페이스의 레이아웃을 관리
 - 다른 뷰컨트롤러와 함께 앱을 구성
 - 화면하나를 관리하는 단위
 
 AutoLayout
 - 아이폰의 다양한 해상도 비율에 대응하기 위한 요소
 - 제약조건을 이용해 뷰의 위치나 크기를 지정하는 요소
 
 IBOutlet & IBAction
 - IBOutlet : 스토리보드에 등록한 UI오브젝트를 코드에서 변수로 접근하게 할수 있도록 만들어 줌
 - IBAction : 버튼과 연결해 이벤트를 처리하는 함수를 만들어 줌
 
 content hugging priority
 - UIFramework에서 제공하는 일부 뷰에는 컨텐츠 고유사이즈라는 개념이 있음
 - UILabel, UIButton과 같이 텍스트나 이미지에따라 크기가 결정되는 뷰
 - 다른 뷰들과의 제약에 의해 본래의 컨텐츠 사이즈보다 늘어나거나 줄어들게 됨
 - 늘어나는 것에 대해 저항하는 제약을 contents hugging
 - 줄어드는 것에 대해 저항하는 제약을 contents compression resistence
 - 고유 컨텐츠 사이즈 변경에 대한 우선순위에 따라 컨텐츠 고유 사이즈보다 늘어나게 할지 줄어들게 할지 정할 수 있음
 - 우선순위가 높으면 크기를 유지하고 낮으면 크기가 변경
 */

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    let disposeBag = DisposeBag()

    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    let quotes = [
        Quote(contents: "죽음을 두려워하는 나머지 삶을 시작조차 못하는 사람이 많다.", name: "벤다이크"),
        Quote(contents: "나는 나 자신을 빼 놓고는 모두 안다.", name: "비용"),
        Quote(contents: "편견이란 실효성이 없는 의견이다.", name: "암브로스 빌"),
        Quote(contents: "분노는 바보들의 가슴속에서만 살아간다.", name: "아인슈타인"),
        Quote(contents: "몇 번이라도 좋다! 이 끔찍한 생이여... 다시!", name: "니체")
    ]
    
    let quote = PublishSubject<Quote>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        quote
            .subscribe(onNext: {
                self.quoteLabel.text = $0.contents
                self.nameLabel.text = $0.name
            })
            .disposed(by: disposeBag)
    }

    @IBAction func tapQuoteGeneratorButton(_ sender: Any) {
        // 랜덤 난수 발생 (0~4)
        let random = Int(arc4random_uniform(5))
        
        quote.onNext(quotes[random])
    }
}

