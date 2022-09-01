//
//  FilterViewModel.swift
//  SearchBlogApp
//
//  Created by Mac on 2022/09/01.
//

import RxSwift
import RxCocoa

struct FilterViewModel {
    let sortButtonTapped = PublishRelay<Void>()
}
