//
//  TodayCollectionViewCell.swift
//  AppStoreSample
//
//  Created by Mac on 2022/03/28.
//

import UIKit
import SnapKit

class TodayCollectionViewCell: UICollectionViewCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        label.text = "앱 이름"
        
        return label
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .white
        label.text = "앱 소개"
        
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .white
        label.text = "앱 설명"
        
        return label
    }()
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 12
        image.backgroundColor = .gray
        
        return image
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        [imageView, titleLabel, subTitleLabel, descriptionLabel].forEach {
            contentView.addSubview($0)
        }
        
        setup()
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 10
    }
    
    func setup() {
        subTitleLabel.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview().inset(24)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(subTitleLabel)
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(4)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(subTitleLabel)
            $0.bottom.equalToSuperview().inset(24)
        }
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
