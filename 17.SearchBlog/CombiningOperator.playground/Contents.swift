import UIKit
import RxSwift

let disposeBag = DisposeBag()

print("-----startWith-----")
let yellow = Observable<String>.of("first", "second", "third")

yellow
    .startWith("teacher")
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

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

print("-----merge-----")
let south = Observable.of("강남", "서초", "강동", "송파")
let north = Observable.of("강북", "동대문", "성동", "은평")

Observable.of(south, north)
    .merge()
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("-----merge2-----")
Observable.of(south, north)
    .merge(maxConcurrent: 1)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

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

print("-----scan-----")
Observable.from((1...10))
    .scan(0, accumulator: +)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

