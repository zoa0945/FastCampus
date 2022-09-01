//
//  BlogList.swift
//  SearchBlogApp
//
//  Created by Mac on 2022/08/13.
//

import UIKit
import RxSwift
import RxCocoa

class BlogList: UITableView {
    let disposeBag = DisposeBag()
    
    let header = FilterView(
        frame: CGRect(
            origin: .zero,
            size: CGSize(width: UIScreen.main.bounds.width, height: 50)
        )
    )
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: BlogListViewModel) {
        header.bind(viewModel.filterViewModel)
        
        viewModel.cellData
            .drive(self.rx.items) { tableView, row, data in
                let index = IndexPath(row: row, section: 0)
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "BlogListCell", for: index) as? BlogListCell else { return UITableViewCell() }
                cell.setData(data)
                return cell
            }
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        backgroundColor = .white
        register(BlogListCell.self, forCellReuseIdentifier: "BlogListCell")
        separatorStyle = .singleLine
        rowHeight = 100
        tableHeaderView = header
    }
}
