//
//  RankingFeatureSectionCollectionViewCell.swift
//  AppStoreSample
//
//  Created by Mac on 2022/04/05.
//

import UIKit
import SnapKit

class RankingFeatureSectionCollectionViewCell: UICollectionViewCell {
    
    static var height: CGFloat = {
        return 70
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 7
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.separator.cgColor
        imageView.backgroundColor = .tertiarySystemGroupedBackground
        
        return imageView
    }()
    
    let appNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .bold)
        
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        
        return label
    }()
    
    let downloadButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .secondarySystemBackground
        button.setTitle("받기", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = .systemFont(ofSize: 13, weight: .bold)
        
        return button
    }()
    
    let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "앱 내 구입"
        label.font = .systemFont(ofSize: 10, weight: .semibold)
        label.textColor = .secondaryLabel
        
        return label
    }()
    
    func setup(rankingFeature: RankingFeature) {
        setupLayout()

        appNameLabel.text = rankingFeature.title
        descriptionLabel.text = rankingFeature.description
        infoLabel.isHidden = !rankingFeature.isInPurchaseApp
    }
}

extension RankingFeatureSectionCollectionViewCell {
    func setupLayout() {
        [
            imageView,
            appNameLabel,
            descriptionLabel,
            downloadButton,
            infoLabel
        ].forEach {
            addSubview($0)
        }
        
        imageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(4)
            $0.leading.equalToSuperview()
            $0.width.equalTo(imageView.snp.height)
        }
        
        appNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.leading.equalTo(imageView.snp.trailing).offset(8)
            $0.trailing.equalTo(downloadButton.snp.leading).offset(8)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.leading.equalTo(appNameLabel.snp.leading)
            $0.top.equalTo(appNameLabel.snp.bottom).offset(4)
        }
        
        downloadButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
            $0.width.equalTo(50)
            $0.height.equalTo(24)
        }
        
        infoLabel.snp.makeConstraints {
            $0.centerX.equalTo(downloadButton.snp.centerX)
            $0.top.equalTo(downloadButton.snp.bottom).offset(4)
        }
    }
}
