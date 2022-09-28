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
    let showFreeShareButton: Signal<Bool>
    let resetPrice: Signal<Void>
    
    let priceValue = PublishRelay<String?>()
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
