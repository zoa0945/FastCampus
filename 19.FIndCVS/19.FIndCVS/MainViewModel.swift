//
//  MainViewModel.swift
//  19.FIndCVS
//
//  Created by zoa0945 on 2022/12/26.
//

import Foundation
import RxSwift
import RxCocoa

class MainViewModel {
    let disposeBag = DisposeBag()
    
    let currentLocationButtonTapped = PublishRelay<Void>()
}
