//
//  BlogListCell.swift
//  SearchBlogApp
//
//  Created by Mac on 2022/08/13.
//

import UIKit
import SnapKit
import Kingfisher

class BlogListCell: UITableViewCell {
    let thumbnailImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 2
        
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .light)
        
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layout()
    }
    
    private func layout() {
        [
            titleLabel,
            descriptionLabel,
            dateLabel,
            thumbnailImageView
        ].forEach {
            addSubview($0)
        }
        
        thumbnailImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(8)
            $0.width.height.equalTo(80)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(8)
            $0.trailing.equalTo(thumbnailImageView.snp.leading).offset(-8)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.equalTo(titleLabel)
            $0.trailing.equalTo(thumbnailImageView.snp.leading).offset(-8)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            $0.leading.equalTo(titleLabel)
            $0.trailing.equalTo(descriptionLabel)
            $0.bottom.equalTo(thumbnailImageView)
        }
    }
    
    func setData(_ data: BlogData) {
        thumbnailImageView.kf.setImage(with: data.thumbnailURL, placeholder: UIImage(systemName: "photo"))
        titleLabel.text = data.title
        descriptionLabel.text = data.description
        
        var dateTime: String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy년 MM월 dd일"
            let contentDate = data.dateTime ?? Date()
            
            return dateFormatter.string(from: contentDate)
        }
        
        dateLabel.text = dateTime
    }
}
