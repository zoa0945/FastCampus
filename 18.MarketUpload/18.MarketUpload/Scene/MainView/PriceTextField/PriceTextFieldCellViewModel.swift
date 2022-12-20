//
//  PriceTextFieldCellViewModel.swift
//  18.MarketUpload
//
//  Created by zoa0945 on 2022/09/28.
//

import Foundation
import RxSwift
import RxCocoa

class PriceTextFieldCellViewModel {
    // ViewModel에서 View로 전달되는 데이터
    // 가격을 작성하지 않으면 무료나눔을 보여주기 위한 Signal
    let showFreeShareButton: Signal<Bool>
    // 제출 버튼을 눌렀을 때 가격이 초기화 되기위한 Signal
    let resetPrice: Signal<Void>
    
    // View에서 ViewModel로 전달되는 데이터
    // 입력한 가격의 데이터
    let priceValue = PublishRelay<String?>()
    // 무료나눔 tap 이벤트
    let freeShareButtonTapped = PublishRelay<Void>()
    
    init() {
        self.showFreeShareButton = Observable
            .merge(
                priceValue.map { $0 ?? "" == "0" },
                freeShareButtonTapped.map { _ in false }
            )
            .asSignal(onErrorJustReturn: false)
        
        self.resetPrice = freeShareButtonTapped
            .asSignal(onErrorSignalWith: .empty())
    }
}
