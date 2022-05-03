//
//  ProfileCollectionViewCell.swift
//  InstagramProto
//
//  Created by Mac on 2022/04/25.
//

import UIKit
import SnapKit

class ProfileCollectionViewCell: UICollectionViewCell {
    private let imageView: UIImageView = {
        let image = UIImageView()
        
        return image
    }()
    
    func setup(with image: UIImage) {
        addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        imageView.backgroundColor = .tertiaryLabel
    }
}
