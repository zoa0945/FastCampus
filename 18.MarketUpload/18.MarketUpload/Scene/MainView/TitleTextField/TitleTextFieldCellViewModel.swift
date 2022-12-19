//
//  TitleTextFieldCellViewModel.swift
//  18.MarketUpload
//
//  Created by zoa0945 on 2022/09/28.
//

import Foundation
import RxSwift
import RxCocoa

// PublishRelay: UIEvent를 받아 방출
class TitleTextFieldViewModel {
    let titleText = PublishRelay<String?>()
}
