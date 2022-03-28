//
//  TodayCollectionViewHeader.swift
//  AppStoreSample
//
//  Created by Mac on 2022/03/28.
//

import UIKit
import SnapKit

class TodayCollectionViewHeader: UICollectionReusableView {
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "00월 00일 일요일"
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .secondaryLabel
        
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "투데이"
        label.font = .systemFont(ofSize: 36, weight: .black)
        label.textColor = .label
        
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        [dateLabel, titleLabel].forEach{
            addSubview($0)
        }
        setup()
    }
    
    func setup() {
        dateLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview()
            $0.top.equalToSuperview().inset(32)
        }
        
        titleLabel.snp.makeConstraints {
            $0.left.equalTo(dateLabel)
            $0.top.equalTo(dateLabel.snp.bottom).offset(8)
        }
    }
}
