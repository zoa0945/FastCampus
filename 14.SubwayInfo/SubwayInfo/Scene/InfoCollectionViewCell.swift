//
//  InfoCollectionViewCell.swift
//  SubwayInfo
//
//  Created by Mac on 2022/04/13.
//

import UIKit
import SnapKit

class InfoCollectionViewCell: UICollectionViewCell {
    let stationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .label
        
        return label
    }()
    
    let infoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .secondaryLabel
        
        return label
    }()
    
    func setup(_ info: ArrivalInfo) {
        setupLayout()
        layer.cornerRadius = 12
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 10
        
        backgroundColor = .systemBackground
        
        stationLabel.text = info.direction
        infoLabel.text = info.arrivalMsg1
    }
}

extension InfoCollectionViewCell {
    func setupLayout() {
        [
            stationLabel,
            infoLabel
        ].forEach {
            addSubview($0)
        }
        
        stationLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(16)
        }
        
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(stationLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(16)
        }
    }
}
