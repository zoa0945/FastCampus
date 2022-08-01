import Foundation
import RxSwift

let disposeBag = DisposeBag()

// Next 이벤트를 무시하는 연산자, complete나 error같은 정지이벤트는 허용
print("-----ignordElements-----")

let sleepMode = PublishSubject<String>()

sleepMode
    .ignoreElements()
    .subscribe { _ in
        print("sleep")
    }
    .disposed(by: disposeBag)

sleepMode.onNext("alarm")
sleepMode.onNext("alarm")
sleepMode.onNext("alarm")

sleepMode.onCompleted()

print("-----elementAt-----")

let wakeUp = PublishSubject<String>()

wakeUp
    .element(at: 2)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

wakeUp.onNext("alarm")
wakeUp.onNext("alarm")
wakeUp.onNext("wakeup")

print("-----filter-----")
Observable.of(1, 2, 3, 4, 5, 6, 7, 8)
    .filter { $0 % 2 == 0 }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

// 첫번째부터 n개의 요소를 skip할 수 있음
print("-----skip-----")
Observable.of(1, 2, 3, 4, 5, 6)
    .skip(5)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

// while 조건을 만족하지 않는 element가 나오면 그때부터 방출
print("-----skipWhile-----")
Observable.of(1, 2, 3, 4, 5)
    .skip(while: {
        $0 % 2 != 0
    })
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

// skip 내부의 OBservable이 onNext이벤트를 나타낼때까지 skip
print("-----skipUntil-----")
let person = PublishSubject<String>()
let open = PublishSubject<String>()

person
    .skip(until: open)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

person.onNext("first")
person.onNext("second")

open.onNext("now open")
person.onNext("third")

// skip의 반대로 원하는 만큼의 element를 취하고 싶을 때 사용
print("-----take-----")
Observable.of("gold", "silver", "bronze", "first", "second")
    .take(3)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

// while 조건을 반족하지 않는 element가 나오면 정지
print("-----takeWhile-----")
Observable.of("gold", "silver", "bronze", "first", "second")
    .take(while: {
        $0 != "bronze"
    })
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

// 방출된 element의 index를 참고하고 싶을 때 사용
print("-----enumerated-----")

Observable.of("gold", "silver", "bronze", "first", "second")
    .enumerated()
    .take(while: {
        $0.index < 3
    })
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

// 연달아 같은 값이 이어질 때 중복된 값을 무시
print("-----distinctUntilChanged-----")
Observable.of("저는", "저는", "앵무새", "앵무새", "앵무새", "앵무새", "입니다", "입니다", "저는")
    .distinctUntilChanged()
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
