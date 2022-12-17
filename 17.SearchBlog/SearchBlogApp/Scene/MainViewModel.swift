//
//  MainViewModel.swift
//  SearchBlogApp
//
//  Created by Mac on 2022/09/01.
//

import RxSwift
import RxCocoa

struct MainViewModel {
    let disposeBag = DisposeBag()
    
    let searchBarViewModel = SearchBarViewModel()
    let blogListViewModel = BlogListViewModel()
    
    let alertActionTapped = PublishRelay<MainViewController.AlertAction>()
    let shouldPresentAlert: Signal<MainViewController.Alert>
    
    init(model: MainModel = MainModel()) {
        let blogResult = searchBarViewModel.shouldLoadResult
            .flatMapLatest(model.searchBlog)
            .share()
        
        let blogValue = blogResult
            .compactMap(model.getBlogValue)
        
        let blogError = blogResult
            .compactMap(model.getBlogError)
        
        let cellData = blogValue
            .map(model.getCellData)
        
        let sortedType = alertActionTapped
            .filter {
                switch $0 {
                case .title, .dateTime:
                    return true
                case .cancel, .confirm:
                    return false
                }
            }
            .startWith(.title)
        
        // Binder: 생성자와 수신자의 단방향 통신을 위한 Trait
        // 수신자는 값을 반환 할 수 없음
        // 데이터를 받아 이벤트를 처리하는 Observer 역할만 함
        // UI Binding에 사용되고 Error 이벤트를 받지 않음
        // Observable의 경우 Error 이벤트가 밠생할 경우 sequence가 종료되고 더 이상의 이벤트가 전달되지 않음
        // Binder에서 이러한 Error 이벤트가 발생할 경우 Binding된 UI가 더이상 변경되지 않고 작동하지 않는것 처럼 보임
        // UI를 업데이트 하는데 사용되므로 MainThread에서 실행되는 것을 보장
        Observable
            .combineLatest(
                sortedType,
                cellData,
                resultSelector: model.sort)
            .bind(to: blogListViewModel.blogCellData)
            .disposed(by: disposeBag)
        
        let alertSheetForSorting = blogListViewModel.filterViewModel.sortButtonTapped
            .map { _ -> MainViewController.Alert in
                return (title: nil, message: nil, actions: [.title, .dateTime, .cancel], style: .actionSheet)
            }
        
        let alertForErrorMessage = blogError
            .map { message -> MainViewController.Alert in
                return (
                    title: "앗!",
                    message: "예상치 못한 오류가 발생했습니다. 잠시 후 다시 시도해주세요. \(message)",
                    actions: [.confirm],
                    style: .alert
                )
            }
        
        // Driver, Signal: Binder와 비슷한 성격을 가짐
        // Error 이벤트를 방출하지 않고 모든 과정이 Main Thread에서 이루어 짐
        // 스트림 공유가 가능함
        // Bind의 경우 Bind를 하는 Observer가 늘어날 때 마다 스트림도 함께 늘어나기 때문에 resource 낭비가 발생할 수 있음
        // Driver, Signal의 경우 스트림을 새로 만드는 것이 아니라 공유를 하기 때문에 resource 낭비를 줄일 수 있음
        // Driver: 새로운 구독을 시작하는 순간 초기값이나 최신값을 전달함 (asDriver)
        // Signal: 구독한 이후에 발생한는 값만 전달 (asSignal)
        self.shouldPresentAlert = Observable
            .merge(
                alertSheetForSorting,
                alertForErrorMessage
            )
            .asSignal(onErrorSignalWith: .empty())
    }
}
