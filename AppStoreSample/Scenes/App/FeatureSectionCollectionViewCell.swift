//
//  FeatureSectionCollectionViewCell.swift
//  AppStoreSample
//
//  Created by Mac on 2022/04/04.
//

import UIKit
import SnapKit
import Kingfisher

class FeatureSectionCollectionViewCell: UICollectionViewCell {
    let typeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBlue
        label.font = .systemFont(ofSize: 12.0, weight: .semibold)
        
        return label
    }()
    
    let appNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 20.0, weight: .bold)
        
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 16.0, weight: .semibold)
        
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 7.0
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.separator.cgColor
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    func setup(feature: Feature) {
        setupLayout()
        
        typeLabel.text = feature.type
        appNameLabel.text = feature.appName
        descriptionLabel.text = feature.description
        
        if let imageURL = URL(string: feature.imageURL) {
            imageView.kf.setImage(with: imageURL)
        }
    }
}

extension FeatureSectionCollectionViewCell {
    func setupLayout() {
        [
            typeLabel,
            appNameLabel,
            descriptionLabel,
            imageView
        ].forEach {
            addSubview($0)
        }
        
        typeLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        appNameLabel.snp.makeConstraints {
            $0.top.equalTo(typeLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(appNameLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            $0.bottom.equalToSuperview().offset(8)
            $0.leading.trailing.equalToSuperview()
            
        }
    }
}
