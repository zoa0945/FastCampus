//
//  BlogListViewModel.swift
//  SearchBlogApp
//
//  Created by Mac on 2022/09/01.
//

import RxSwift
import RxCocoa

struct BlogListViewModel {
    let filterViewModel = FilterViewModel()
    
    let blogCellData = PublishSubject<[BlogData]>()
    let cellData: Driver<[BlogData]>
    
    init() {
        self.cellData = blogCellData
            .asDriver(onErrorJustReturn: [])
    }
}
