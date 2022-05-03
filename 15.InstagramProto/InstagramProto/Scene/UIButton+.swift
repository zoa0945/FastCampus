//
//  UIButton+.swift
//  InstagramProto
//
//  Created by Mac on 2022/04/21.
//

import UIKit

extension UIButton {
    func setImage(systemName: String) {
        contentHorizontalAlignment = .fill
        contentVerticalAlignment = .fill
        
        imageView?.contentMode = .scaleAspectFit
        
        setImage(UIImage(systemName: systemName), for: .normal)
    }
}
