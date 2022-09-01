import RxSwift

let disposeBag = DisposeBag()

print("-----toArray-----")
Observable.of("A", "B", "C")
    .toArray()
    .subscribe(onSuccess: {
        print($0)
    })
    .disposed(by: disposeBag)

print("-----map-----")
Observable.of(Date())
    .map { date -> String in
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("-----flatMap-----")
protocol Athlete {
    var score: BehaviorSubject<Int> { get }
}

struct Arrow: Athlete {
    var score: BehaviorSubject<Int>
}

let korea = Arrow(score: BehaviorSubject<Int>(value: 10))
let us = Arrow(score: BehaviorSubject<Int>(value: 8))

let olympic = PublishSubject<Athlete>()

olympic
    .flatMap { athlete in
        athlete.score
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

korea.score.onNext(10)
olympic.onNext(korea)

olympic.onNext(us)
korea.score.onNext(10)
us.score.onNext(9)

print("-----flatMapLatest-----")
struct highJump: Athlete {
    var score: BehaviorSubject<Int>
}

let seoul = highJump(score: BehaviorSubject<Int>(value: 7))
let jeju = highJump(score: BehaviorSubject<Int>(value: 6))

let kSports = PublishSubject<Athlete>()

kSports
    .flatMapLatest { athlete in
        athlete.score
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

kSports.onNext(seoul)
seoul.score.onNext(9)

kSports.onNext(jeju)
seoul.score.onNext(10)
jeju.score.onNext(8)

print("-----materialize and dematerialize-----")
enum AthleteError: Error {
    case fastStart
}

struct Runner: Athlete {
    var score: BehaviorSubject<Int>
}

let first = Runner(score: BehaviorSubject<Int>(value: 0))
let second = Runner(score: BehaviorSubject<Int>(value: 1))

let run100M = BehaviorSubject<Athlete>(value: first)

run100M
    .flatMap { athlete in
        athlete.score
            .materialize()
    }
    .filter {
        guard let error = $0.error else {
            return true
        }
        print(error)
        return false
    }
    .dematerialize()
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

first.score.onNext(1)
first.score.onError(AthleteError.fastStart)
first.score.onNext(2)

run100M.onNext(second)

print("-----전화번호 11자리-----")
let inputNumber = PublishSubject<Int?>()

let list: [Int] = []

inputNumber
    .flatMap {
        $0 == nil
            ? Observable.empty()
            : Observable.just($0)
    }
    .map { $0! }
    .skip(while: { $0 != 0 })
    .take(11)
    .toArray()
    .asObservable()
    .map {
        $0.map {
            String($0)
        }
    }
    .map { numbers in
        var numberList = numbers
        numberList.insert("-", at: 3)
        numberList.insert("-", at: 8)
        let number = numberList.reduce("", +)
        return number
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

inputNumber.onNext(10)
inputNumber.onNext(0)
inputNumber.onNext(nil)
inputNumber.onNext(1)
inputNumber.onNext(0)
inputNumber.onNext(4)
inputNumber.onNext(3)
inputNumber.onNext(nil)
inputNumber.onNext(1)
inputNumber.onNext(8)
inputNumber.onNext(9)
inputNumber.onNext(4)
inputNumber.onNext(9)
inputNumber.onNext(1)
