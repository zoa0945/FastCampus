import Foundation
import RxSwift

var disposeBag = DisposeBag()

enum TraitsError: Error {
    case single
    case maybe
    case completable
}

// success 또는 error 이벤트를 한번만 방출하는 observable
// 파일저장이나 파일 다운로드, 데이터 로딩과 같이 값을 산출하는 비동기적 연산에 사용
// ex) 사진을 저장할 때 저장이 됐는지 에러가 발생했는지 같이 정확히 한가지 요소만을 방출하는 연산자를 레핑할때 사용
print("=====Single1=====")
Single<String>.just("Check")
    .subscribe {
        print($0)
    } onFailure: {
        print("error: \($0)")
    } onDisposed: {
        print("disposed")
    }
    .disposed(by: disposeBag)

print("=====Single2=====")
Observable.create { observer -> Disposable in
        observer.on(.error(TraitsError.single))
        return Disposables.create()
    }
    .asSingle()
    .subscribe {
        print($0)
    } onFailure: {
        print("error: \($0.localizedDescription )")
    } onDisposed: {
        print("disposed")
    }
    .disposed(by: disposeBag)

print("=====Single3=====")
struct SomeJSON: Codable {
    let name: String
}

enum JSONError: Error {
    case decodingError
}

let json1 = """
    {"name":"park"}
    """

let json2 = """
    {"my_name": "young"}
    """

func decodeJSON(json: String) -> Single<SomeJSON> {
    let observable: Single<SomeJSON> = Single<SomeJSON>.create { observer -> Disposable in
        guard let data = json.data(using: .utf8),
              let result = try? JSONDecoder().decode(SomeJSON.self, from: data) else {
            observer(.failure(JSONError.decodingError))
            return Disposables.create()
        }
        
        observer(.success(result))
        return Disposables.create()
    }
    
    return observable
}

decodeJSON(json: json1)
    .subscribe {
        switch $0 {
        case .success(let json):
            print(json.name)
        case .failure(let error):
            print(error)
        }
    }
    .disposed(by: disposeBag)

decodeJSON(json: json2)
    .subscribe {
        switch $0 {
        case .success(let json):
            print(json.name)
        case .failure(let error):
            print(error)
        }
    }
    .disposed(by: disposeBag)

// Single과 비슷하지만 성공적으로 Complete 되어도 아무것도 방출하지 않음
// 중복된 값이 저장될 때 Complete 이벤트를 방출시켜 다음으로 넘어갈 수 있음
print("=====Maybe1=====")
Maybe<String>.just("Good")
    .subscribe {
        print($0)
    } onError: {
        print($0.localizedDescription)
    } onCompleted: {
        print("completed")
    } onDisposed: {
        print("disposed")
    }
    .disposed(by: disposeBag)

Observable<String>.create { observer -> Disposable in
    observer.onError(TraitsError.maybe)
    return Disposables.create()
}
.asMaybe()
.subscribe(
    onSuccess: {
        print("success: \($0)")
    },
    onError: {
        print("error: \($0)")
    },
    onCompleted: {
        print("completed")
    },
    onDisposed: {
        print("disposed")
    }
)
.disposed(by: disposeBag)

// complete 또는 error 만 방출하는 observable
// Completable로 직접 생성
// ex) 작업하는 동안 어떤 데이터가 자동으로 저장되는 기능을 만들 때
// 완료가 됐을 때 알림을 띄우거나 오류가 발생했을 때 알림을 띄우고 싶을 경우
print("=====Completable1=====")
Completable.create { observer -> Disposable in
    observer(.error(TraitsError.completable))
    return Disposables.create()
}
.subscribe(
    onCompleted: {
        print("completed")
    },
    onError: {
        print("error: \($0)")
    },
    onDisposed: {
        print("disposed")
    }
)
.disposed(by: disposeBag)

print("=====Completable2=====")
Completable.create { observer -> Disposable in
    observer(.completed)
    return Disposables.create()
}
.subscribe {
        print($0)
}
.disposed(by: disposeBag)
