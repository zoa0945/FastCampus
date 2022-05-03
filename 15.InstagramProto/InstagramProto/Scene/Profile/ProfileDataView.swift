//
//  ProfileDataView.swift
//  InstagramProto
//
//  Created by Mac on 2022/04/25.
//

import UIKit
import SnapKit

class ProfileDataView: UIView {
    let title: String
    let count: Int
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.text = title
        
        return label
    }()
    
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.text = "\(count)"
        
        return label
    }()
    
    init(title: String, count: Int) {
        self.title = title
        self.count = count

        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfileDataView {
    func setup() {
        let stackView = UIStackView(arrangedSubviews: [countLabel, titleLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 4
        
        addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
