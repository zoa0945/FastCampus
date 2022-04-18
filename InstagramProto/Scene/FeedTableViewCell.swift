//
//  FeedTableViewCell.swift
//  InstagramProto
//
//  Created by Mac on 2022/04/18.
//

import UIKit
import SnapKit

class FeedTableViewCell: UITableViewCell {
    lazy var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .tertiaryLabel
        
        return imageView
    }()
    
    let likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        
        return button
    }()
    
    let commentButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "message"), for: .normal)
        
        return button
    }()
    
    let dmButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "paperplane"), for: .normal)
        
        return button
    }()
    
    let bookMarkButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        
        return button
    }()
    
    let statusLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.text = "홍길동님 외 12명이 좋아합니다."
        
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 5
        label.text = """
            diffffffffffffsidofkjosidjffffffffffffffffffoisdjf
            oisdjfadieojfoiwjeoifjwoijef
            oidjfoiwnoigjwoijfoijw
            doijfoiejgoijwoiejg
        """
        
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.text = "1일 전"
        
        return label
    }()
    
    func setup() {
        setupLayout()
    }
}

extension FeedTableViewCell {
    func setupLayout() {
        [
            postImageView,
            likeButton,
            commentButton,
            dmButton,
            bookMarkButton,
            statusLabel,
            descriptionLabel,
            timeLabel
        ].forEach {
            addSubview($0)
        }
        
        postImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(postImageView.snp.width)
        }
        
        let buttonWidth: CGFloat = 24
        let buttonInset: CGFloat = 16
        
        likeButton.snp.makeConstraints {
            $0.top.equalTo(postImageView.snp.bottom).offset(buttonInset)
            $0.leading.equalToSuperview().inset(buttonInset)
            $0.width.height.equalTo(buttonWidth)
        }
        
        commentButton.snp.makeConstraints {
            $0.top.equalTo(likeButton.snp.top)
            $0.leading.equalTo(likeButton.snp.trailing).offset(12)
            $0.width.height.equalTo(buttonWidth)
        }
        
        dmButton.snp.makeConstraints {
            $0.top.equalTo(likeButton.snp.top)
            $0.leading.equalTo(commentButton.snp.trailing).offset(12)
            $0.width.height.equalTo(buttonWidth)
        }
        
        bookMarkButton.snp.makeConstraints {
            $0.top.equalTo(likeButton.snp.top)
            $0.trailing.equalToSuperview().inset(buttonInset)
            $0.width.height.equalTo(buttonWidth)
        }
        
        statusLabel.snp.makeConstraints {
            $0.top.equalTo(likeButton.snp.bottom).offset(14)
            $0.leading.equalTo(likeButton.snp.leading)
            $0.trailing.equalTo(bookMarkButton.snp.trailing)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(statusLabel.snp.bottom).offset(8)
            $0.leading.equalTo(likeButton.snp.leading)
            $0.trailing.equalTo(bookMarkButton.snp.trailing)
        }
        
        timeLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            $0.leading.equalTo(likeButton.snp.leading)
            $0.trailing.equalTo(bookMarkButton.snp.trailing)
        }
    }
}
