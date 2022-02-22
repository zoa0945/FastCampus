//
//  ContentCollectionViewHeader.swift
//  NetflixStyleSampleApp
//
//  Created by Mac on 2022/02/16.
//

import UIKit
import SnapKit

class ContentCollectionViewHeader: UICollectionReusableView {
    let sectionLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        sectionLabel.font = .systemFont(ofSize: 17, weight: .bold)
        sectionLabel.textColor = .white
        sectionLabel.sizeToFit()
        
        addSubview(sectionLabel)
        
        sectionLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.top.bottom.leading.equalToSuperview().offset(10)
        }
    }
}
