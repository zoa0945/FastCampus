//
//  AppDetailViewController.swift
//  AppStoreSample
//
//  Created by Mac on 2022/04/07.
//

import UIKit
import SnapKit

class AppDetailViewController: UIViewController {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 20, weight: .bold)
        
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 14, weight: .medium)
        
        return label
    }()
    
    let downloadButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 12.0
        button.setTitle("받기", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13, weight: .bold)
        
        return button
    }()
    
    let shareButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.tintColor = .systemBlue
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setup()
        
        imageView.backgroundColor = .lightGray
        titleLabel.text = "title"
        subtitleLabel.text = "subtitle"
    }
}

extension AppDetailViewController {
    func setup() {
        [
            imageView,
            titleLabel,
            subtitleLabel,
            downloadButton,
            shareButton
        ].forEach {
            view.addSubview($0)
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(32)
            $0.leading.equalToSuperview().inset(16)
            $0.height.equalTo(100)
            $0.width.equalTo(imageView.snp.height)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.top)
            $0.leading.equalTo(imageView.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.equalTo(titleLabel.snp.leading)
        }
        
        downloadButton.snp.makeConstraints {
            $0.bottom.equalTo(imageView.snp.bottom)
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.height.equalTo(24)
            $0.width.equalTo(60)
        }
        
        shareButton.snp.makeConstraints {
            $0.centerY.equalTo(downloadButton.snp.centerY)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.width.equalTo(32)
        }
    }
}
