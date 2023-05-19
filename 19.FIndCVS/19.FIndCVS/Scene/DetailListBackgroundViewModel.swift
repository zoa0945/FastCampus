//
//  DetailListBackgroundViewModel.swift
//  19.FIndCVS
//
//  Created by zoa0945 on 2023/05/19.
//

import RxSwift
import RxCocoa

class DetailListBackgroundViewModel {
    // viewModel에서 외부로 전달될 값
    let isStatusLabelHidden: Signal<Bool>
    
    // 외부에서 전달받을 값
    let shouldHideStatusLabel = PublishSubject<Bool>()
    
    init() {
        isStatusLabelHidden = shouldHideStatusLabel
            .asSignal(onErrorJustReturn: true)
    }
}
