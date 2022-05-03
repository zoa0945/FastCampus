//
//  UploadViewController.swift
//  InstagramProto
//
//  Created by Mac on 2022/04/25.
//

import UIKit
import SnapKit

class UploadViewController: UIViewController {
    private let uploadImage: UIImage
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        
        return image
    }()
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.text = "문구를 입력해주세요."
        textView.textColor = .secondaryLabel
        textView.font = .systemFont(ofSize: 15)
        
        textView.delegate = self
        
        return textView
    }()
    
    init(uploadImage: UIImage) {
        self.uploadImage = uploadImage
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setupNavigation()
        setupLayout()
        
        imageView.image = uploadImage
    }
}

extension UploadViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.textColor == .secondaryLabel else { return }
        
        textView.text = nil
        textView.textColor = .label
    }
}

private extension UploadViewController {
    func setupNavigation() {
        navigationItem.title = "새 게시물"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "공유",
            style: .plain,
            target: self,
            action: #selector(didTapRightButton)
        )
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "취소",
            style: .plain,
            target: self,
            action: #selector(didTapLeftButton)
        )
        
    }
    
    @objc func didTapLeftButton() {
        dismiss(animated: true)
    }
    
    @objc func didTapRightButton() {
        dismiss(animated: true)
    }
    
    func setupLayout() {
        [
            imageView,
            textView
        ].forEach {
            view.addSubview($0)
        }
        
        let inset: CGFloat = 16
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(inset)
            $0.leading.equalToSuperview().inset(inset)
            $0.width.equalTo(100)
            $0.height.equalTo(imageView.snp.width)
        }
        
        textView.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.top)
            $0.leading.equalTo(imageView.snp.trailing).offset(inset)
            $0.trailing.equalToSuperview().inset(inset)
            $0.bottom.equalTo(imageView.snp.bottom)
        }
    }
}
