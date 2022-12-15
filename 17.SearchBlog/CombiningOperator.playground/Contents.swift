import UIKit
import RxSwift

let disposeBag = DisposeBag()

// 초기값(시작값)을 onNext 이벤트 전에 추가
// 해당 Observable과 같은 타입을 추가할 수 있음
// 여러개의 sequence를 순서대로 append하는 방식
print("-----startWith-----")
let yellow = Observable<String>.of("first", "second", "third")

yellow
    .startWith("teacher")
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

// sequence와 sequence를 합쳐줌
// 여러개의 sequence를 순서대로 append하는 방식
print("-----concat-----")
let yellow2 = Observable<String>.of("first", "second", "third")
let teacher = Observable<String>.of("teacher")

let temp = Observable
    .concat([teacher, yellow2])

temp
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

teacher
    .concat(yellow2)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

// 여러개의 sequence 중 매핑되는 sequence를 순서대로 나타냄
// 여러개의 sequence를 순서대로 append하는 방식
print("-----concatMap-----")
let student: [String: Observable<String>] = [
    "yellow": Observable.of("first", "second", "third"),
    "blue": Observable.of("fourth", "fifth")
]

Observable.of("yellow", "blue")
    .concatMap { classes in
        student[classes] ?? .empty()
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

// 순서를 보장하지 않고 여러개의 sequence를 합침
// merge되는 여러개의 sequence는 독립적으로 하나의 sequence에 에러가 발생하면
// merge되는 Observable 또한 error 이벤트를 방출하고 종료됨
print("-----merge-----")
let south = Observable.of("강남", "서초", "강동", "송파")
let north = Observable.of("강북", "동대문", "성동", "은평")

Observable.of(south, north)
    .merge()
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

// maxConcurrnet: 순서를 보장할 sequence의 개수를 정의
// maxConcurrent 만큼의 sequence가 방출되면 순서 상관없이 방출됨
print("-----merge2-----")
Observable.of(south, north)
    .merge(maxConcurrent: 1)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

// combineLatest에 의해 결합된 여러개의 sequence들은 값이 방출될 때마다
// closure를 호출하게 되고 각 sequence에서 가장 최근에 방출된 값들을 사용하여 closure 내부 작업을 진행
print("-----combineLatest-----")
let firstName = PublishSubject<String>()
let secondName = PublishSubject<String>()

let name = Observable
    .combineLatest(firstName, secondName) { first, second in
        first + second
    }

name
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

firstName.onNext("김")
secondName.onNext("똘똘")
secondName.onNext("철수")
secondName.onNext("영희")
firstName.onNext("나")
firstName.onNext("박")
firstName.onNext("이")

print("-----combineLatest2-----")
let dateStyle = Observable<DateFormatter.Style>.of(.short, .long)
let now = Observable<Date>.of(Date())

let currentDate = Observable
    .combineLatest(dateStyle, now) { style, now -> String in
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = style
        return dateFormatter.string(from: now)
    }

currentDate
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("-----combineLatest3-----")
let fullName = Observable
    .combineLatest([firstName, secondName]) { name in
        name.joined(separator: " ")
    }

fullName
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

firstName.onNext("Kim")
secondName.onNext("Paul")
secondName.onNext("Stella")
secondName.onNext("Lily")

// zip된 여러개의 sequence의 같은 index에 있는 element를 방출해
// closure 내부 작업을 진행
// element가 모두 방출된 sequence가 하나라도 있으면 중단
print("-----zip-----")
enum WinLose {
    case win
    case lose
}

let winLose = Observable<WinLose>.of(.win, .win, .lose, .win, .lose)
let country = Observable<String>.of("KR", "US", "JP", "CH", "BZ")

let result = Observable
    .zip(winLose, country) { res, coun in
        return coun + "선수" + "\(res)"
    }

result
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

// 트리거가 되는 Observable에 onNext 이벤트가 발생하게 되면
// withLatestFrom에 들어간 두번째 Observable의 가장 최근 이벤트가 실행됨
print("-----withLatestFrom-----")
let trigger = PublishSubject<Void>()
let runner = PublishSubject<String>()

trigger
    .withLatestFrom(runner)
    .distinctUntilChanged()
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

runner.onNext("first")
runner.onNext("second")
runner.onNext("third")

trigger.onNext(Void())
trigger.onNext(Void())

// withLatestFrom과 같은 동작을 하지만
// 트리거가 되는 Observable이 단 한번의 이벤트만 발생시킨다
print("-----sample-----")
let start = PublishSubject<Void>()
let f1 = PublishSubject<String>()

f1
    .sample(start)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

f1.onNext("first")
f1.onNext("second")
f1.onNext("third")
start.onNext(Void())
start.onNext(Void())

// amb로 연결된 두개의 Obeervable을 모두 구독하지만
// 두개 중 이벤트가 먼저 발생한 Observable의 이벤트만 방출하고
// 나머지 Observable의 이벤트는 발생시키지 않음
print("-----amb-----")
let bus1 = PublishSubject<String>()
let bus2 = PublishSubject<String>()

let station = bus1.amb(bus2)

station
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

bus1.onNext("customer9")
bus2.onNext("customer1")
bus2.onNext("customer2")
bus1.onNext("customer5")
bus2.onNext("customer3")
bus1.onNext("customer6")
bus2.onNext("customer4")
bus1.onNext("customer7")
bus1.onNext("customer8")

// source Observable로 들어온 마지막 sequence의 이벤트만 방출하게 됨
print("-----switchLatest-----")
let student1 = PublishSubject<String>()
let student2 = PublishSubject<String>()
let student3 = PublishSubject<String>()

let hands = PublishSubject<Observable<String>>()

let classes2 = hands.switchLatest()

classes2
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

hands.onNext(student1)
student1.onNext("hi1")
student2.onNext("hi2")

hands.onNext(student2)
student2.onNext("hi3")
student1.onNext("hi4")

hands.onNext(student3)
student2.onNext("hi5")
student1.onNext("hi6")
student3.onNext("hi7")

hands.onNext(student3)
student1.onNext("hi8")
student2.onNext("hi9")
student3.onNext("hi10")
student2.onNext("hi11")

// swift의 고차함수 reduce와 같은 동작
print("-----reduce-----")
Observable.from((1...10))
    .reduce(0) { summary, newValue in
        return summary + newValue
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

// reduce와 같이 동작하지만 scan은 매번 element가 들어올 때마다
// 변하는 값들을 방출하여 이벤트를 발생시킴
print("-----scan-----")
Observable.from((1...10))
    .scan(0, accumulator: +)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

