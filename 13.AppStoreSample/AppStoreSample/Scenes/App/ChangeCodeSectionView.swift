//
//  ChangeCodeSectionView.swift
//  AppStoreSample
//
//  Created by Mac on 2022/04/05.
//

import UIKit
import SnapKit

class ChangeCodeSectionView: UIView {
    let changeButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("코드 교환", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        
        button.backgroundColor = .tertiarySystemGroupedBackground
        button.layer.cornerRadius = 7.0
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(changeButton)
        
        changeButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.bottom.equalToSuperview().inset(32)
            $0.height.equalTo(40)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
