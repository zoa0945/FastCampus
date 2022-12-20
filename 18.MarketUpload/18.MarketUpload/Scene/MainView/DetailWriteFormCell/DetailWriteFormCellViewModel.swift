//
//  DetailWriteFormCellViewModel.swift
//  18.MarketUpload
//
//  Created by zoa0945 on 2022/12/20.
//

import RxSwift
import RxCocoa

class DetailWriteFormCellViewModel {
    // View에서 ViewModel로 전달되는 데이터
    // 내용에 입력되는 데이터
    let contentValue = PublishRelay<String?>()
}
