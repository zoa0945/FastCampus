//
//  ProfileViewController.swift
//  InstagramProto
//
//  Created by Mac on 2022/04/23.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController {
    private lazy var profileImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 40
        image.clipsToBounds = true
        image.layer.borderWidth = 1
        image.layer.borderColor = UIColor.quaternaryLabel.cgColor
        
        return image
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "User Name"
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "안녕하세요 반갑습니다"
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var followButton: UIButton = {
        let button = UIButton()
        button.setTitle("팔로우", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        button.backgroundColor = .systemBlue
        
        button.layer.cornerRadius = 3
        
        return button
    }()
    
    private lazy var messageButton: UIButton = {
        let button = UIButton()
        button.setTitle("팔로우", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        button.backgroundColor = .white
        
        button.layer.cornerRadius = 3
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.tertiaryLabel.cgColor
        
        return button
    }()
    
    private let photoDataView = ProfileDataView(title: "게시물", count: 12)
    private let followerDataView = ProfileDataView(title: "팔로워", count: 2_000)
    private let followingDataView = ProfileDataView(title: "팔로잉", count: 2)
    
    private lazy var profileCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0.5
        layout.minimumInteritemSpacing = 0.5
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: "ProfileCollectionViewCell")
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupLayout()
    }
}

extension ProfileViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCollectionViewCell", for: indexPath) as? ProfileCollectionViewCell else { return UICollectionViewCell() }

        cell.setup(with: UIImage())
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (collectionView.frame.width - 1) / 3
        return CGSize(width: width, height: width)
    }
}

extension ProfileViewController {
    func setupNavigation() {
        navigationItem.title = "UserName"
        
        let infoButton = UIBarButtonItem(
            image: UIImage(systemName: "ellipsis"),
            style: .plain,
            target: self,
            action: #selector(didTapRightBarButtonItem)
        )
        
        navigationItem.rightBarButtonItem = infoButton
    }
    
    @objc func didTapRightBarButtonItem() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        [
            UIAlertAction(title: "회원 정보 변경", style: .default),
            UIAlertAction(title: "탈퇴하기", style: .destructive),
            UIAlertAction(title: "닫기", style: .cancel)
        ].forEach {
            actionSheet.addAction($0)
        }
        
        present(actionSheet, animated: true)
    }
    
    func setupLayout() {
        let buttonStackView = UIStackView(arrangedSubviews: [followButton, messageButton])
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = 4
        
        let dataStackView = UIStackView(arrangedSubviews: [photoDataView, followerDataView, followingDataView])
        dataStackView.axis = .horizontal
        dataStackView.distribution = .fillEqually
        dataStackView.spacing = 4
        
        [
            profileImage,
            dataStackView,
            nameLabel,
            descriptionLabel,
            buttonStackView,
            profileCollectionView
        ].forEach {
            view.addSubview($0)
        }
        
        let inset: CGFloat = 16
        
        profileImage.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(inset)
            $0.leading.equalToSuperview().inset(inset)
            $0.width.equalTo(80)
            $0.height.equalTo(profileImage.snp.width)
        }
        
        dataStackView.snp.makeConstraints {
            $0.centerY.equalTo(profileImage.snp.centerY)
            $0.leading.equalTo(profileImage.snp.trailing).offset(inset)
            $0.trailing.equalToSuperview().inset(inset)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImage.snp.bottom).offset(12)
            $0.leading.equalTo(profileImage.snp.leading)
            $0.trailing.equalToSuperview().inset(inset)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(6)
            $0.leading.equalTo(nameLabel.snp.leading)
            $0.trailing.equalTo(nameLabel.snp.trailing)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(12)
            $0.leading.equalTo(nameLabel.snp.leading)
            $0.trailing.equalTo(nameLabel.snp.trailing)
        }
        
        profileCollectionView.snp.makeConstraints {
            $0.top.equalTo(buttonStackView.snp.bottom).offset(12)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
