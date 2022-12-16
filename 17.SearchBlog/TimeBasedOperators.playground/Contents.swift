import UIKit
import RxSwift
import RxCocoa
import PlaygroundSupport

let disposeBag = DisposeBag()

// 연결된 Observable이 이전에 방출한 이벤트 중 buffersize만큼의 이벤트를 방출함
// replay관련 method를 사용할 때는 connect()를 통해 연결하고 싶은 Observable과 연결해야함
// 구독 이후 발생한 이벤트는 정상적으로 방출함
print("-----replay-----")
let hello = PublishSubject<String>()
let bird = hello.replay(1)

bird.connect()

hello.onNext("hello")
hello.onNext("hi")

bird
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

hello.onNext("hello world")

// replay와 같이 동작하지만 buffersize 제한 없이 지나간 모든 이벤트를 방출하게 됨
print("-----replayAll-----")
let doctorStrange = PublishSubject<String>()
let timeStone = doctorStrange.replayAll()
timeStone.connect()

doctorStrange.onNext("도르마무")
doctorStrange.onNext("거래를 하러왔다")

timeStone
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("-----buffer-----")
//let source = PublishSubject<String>()
//
//var count = 0
//// Timer 생성, Foundation 내부에 있는 DispatchSource의 타이머
//let timer = DispatchSource.makeTimerSource()
//
//// deadline: 작업이 진행되는 시점, repeating: 작업이 반복되는 시간
//timer.schedule(deadline: .now() + 2, repeating: .seconds(1))
//// setEventHandler: timer에 설정된 시간마다 진행되는 complitionHandler
//timer.setEventHandler {
//    count += 1
//    source.onNext("\(count)")
//}
//timer.resume()
//
//source
//    .buffer(
//        // timeSpan마다 source에서 element를 받아옴
//        timeSpan: .seconds(2),
//        // Observable의 element가 가질 수 있는 최대 요소의 개수
//        count: 2,
//        // MainThred의 스케줄러를 얻어옴
//        scheduler: MainScheduler.instance
//    )
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)

// buffer와 유사하게 동작하지만 buffer는 array를 방출하는 대신
// window는 Observable을 방출함
print("-----window-----")
//// 최대로 만들어낼 Observable수
//let observableCount = 1
//// timeSpan 설정
//let makeTime = RxTimeInterval.seconds(2)
//
//let window = PublishSubject<String>()
//
//var windowCount = 0
//let windowTimerSouce = DispatchSource.makeTimerSource()
//windowTimerSouce.schedule(deadline: .now() + 2, repeating: .seconds(1))
//windowTimerSouce.setEventHandler {
//    windowCount += 1
//    window.onNext("\(windowCount)")
//}
//windowTimerSouce.resume()
//
//window
//    .window(
//        timeSpan: makeTime,
//        count: observableCount,
//        scheduler: MainScheduler.instance
//    )
//    .flatMap { windowObservable -> Observable<(index: Int, element: String)> in
//        return windowObservable.enumerated()
//    }
//    .subscribe(onNext: {
//        print("\($0.index)번째 Observable의 요소: \($0.element)")
//    })
//    .disposed(by: disposeBag)

// 구독을 지연시키는 method
// setEventHandler 내부의 작업은 진행되어 이벤트는 방출되지만
// 구독은 delaySubscription의 deadline 이후부터 진행됨
print("-----delaySubscription-----")
//let delaySource = PublishSubject<String>()
//
//var delayCount = 0
//let delayTimeSource = DispatchSource.makeTimerSource()
//delayTimeSource.schedule(deadline: .now() + 2, repeating: .seconds(1))
//delayTimeSource.setEventHandler {
//    delayCount += 2
//    delaySource.onNext("\(delayCount)")
//}
//delayTimeSource.resume()
//
//delaySource
//    .delaySubscription(.seconds(5), scheduler: MainScheduler.instance)
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)

// 구독은 처음부터 하지만 source가 되는 Observable의 이벤트 방출을 지연시킴
print("-----delay-----")
//let delaySubject = PublishSubject<String>()
//
//var delayCount = 0
//let delayTimeSource = DispatchSource.makeTimerSource()
//delayTimeSource.schedule(deadline: .now(), repeating: .seconds(1))
//delayTimeSource.setEventHandler {
//    delayCount += 3
//    delaySubject.onNext("\(delayCount)")
//}
//delayTimeSource.resume()
//
//delaySubject
//    .delay(.seconds(5), scheduler: MainScheduler.instance)
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)

// interval에 지정된 시간마다 Int 타입의 count를 방출해줌
//print("-----interval-----")
//Observable<Int>
//    .interval(.seconds(3), scheduler: MainScheduler.instance)
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)

// duetime이 지난 뒤 period 시간 마다 Int 타입의 count를 방출해줌
print("-----timer-----")
//Observable<Int>
//    .timer(.seconds(3), period: .seconds(1), scheduler: MainScheduler.instance)
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)

// 새로운 이벤트가 발생하고 난 뒤 timeout에 설정한 시간동안 이벤트가 방출되지 않으면 error를 발생시킴
print("-----timeout-----")
let pushPushButton = UIButton(type: .system)
pushPushButton.setTitle("눌러주세요!", for: .normal)
pushPushButton.sizeToFit()

PlaygroundPage.current.liveView = pushPushButton

pushPushButton.rx.tap
    .do(onNext: {
        print("tap")
    })
    .timeout(.seconds(5), scheduler: MainScheduler.instance)
    .subscribe {
        print($0)
    }
    .disposed(by: disposeBag)

