import UIKit
import RxSwift
import RxCocoa
import PlaygroundSupport

let disposeBag = DisposeBag()

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
//let timer = DispatchSource.makeTimerSource()
//
//timer.schedule(deadline: .now() + 2, repeating: .seconds(1))
//timer.setEventHandler {
//    count += 1
//    source.onNext("\(count)")
//}
//timer.resume()
//
//source
//    .buffer(
//        timeSpan: .seconds(2),
//        count: 2,
//        scheduler: MainScheduler.instance
//    )
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)

print("-----window-----")
//let observableCount = 1
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

print("-----delay-----")
//let delaySubject = PublishSubject<String>()
//
//var delayCount = 0
//let delayTimeSource = DispatchSource.makeTimerSource()
//delayTimeSource.schedule(deadline: .now() + 2, repeating: .seconds(1))
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

print("-----interval-----")
//Observable<Int>
//    .interval(.seconds(3), scheduler: MainScheduler.instance)
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)

print("-----timer-----")
//Observable<Int>
//    .timer(.seconds(3), period: .seconds(1), scheduler: MainScheduler.instance)
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)

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

