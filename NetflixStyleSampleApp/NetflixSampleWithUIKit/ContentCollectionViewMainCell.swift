//
//  ContentCollectionViewMainCell.swift
//  NetflixStyleSampleApp
//
//  Created by Mac on 2022/02/16.
//

import UIKit
import SnapKit

class ContentCollectionViewMainCell: UICollectionViewCell {
    let baseStackView = UIStackView()
    
    let imageView = UIImageView()
    let descriptionLabel = UILabel()
    let contentStackView = UIStackView()
    
    let plusButton = UIButton()
    let playButton = UIButton()
    let infoButton = UIButton()
    
    let menuStackView = UIStackView()
    
    let tvButton = UIButton()
    let movieButton = UIButton()
    let categoryButton = UIButton()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        [baseStackView, menuStackView].forEach {
            contentView.addSubview($0)
        }
        
        // baseStackView
        baseStackView.axis = .vertical
        baseStackView.alignment = .center
        baseStackView.distribution = .fillProportionally
        baseStackView.spacing = 5
        
        baseStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        [imageView, descriptionLabel, contentStackView].forEach {
            baseStackView.addArrangedSubview($0)
        }
        
        imageView.contentMode = .scaleAspectFit
        
        imageView.snp.makeConstraints {
            $0.width.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(imageView.snp.width)
        }
        
        descriptionLabel.font = .systemFont(ofSize: 13)
        descriptionLabel.textColor = .white
        descriptionLabel.sizeToFit()
        
        contentStackView.axis = .horizontal
        contentStackView.alignment = .center
        contentStackView.distribution = .equalCentering
        contentStackView.spacing = 20
        
        contentStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
        [plusButton, playButton, infoButton].forEach {
            contentStackView.addArrangedSubview($0)
        }
        
        [plusButton, infoButton].forEach {
            $0.titleLabel?.font = .systemFont(ofSize: 13)
            $0.setTitleColor(.white, for: .normal)
        }
        
        plusButton.setTitle("내가 찜한 컨텐츠", for: .normal)
        plusButton.addTarget(self, action: #selector(tapPlusButton), for: .touchUpInside)
        
        infoButton.setTitle("정보", for: .normal)
        infoButton.addTarget(self, action: #selector(tapInfoButton), for: .touchUpInside)
        
        playButton.setTitle("재생", for: .normal)
        playButton.setTitleColor(.black, for: .normal)
        playButton.backgroundColor = .white
        playButton.layer.cornerRadius = 3
        playButton.snp.makeConstraints {
            $0.width.equalTo(90)
            $0.height.equalTo(30)
        }
        playButton.addTarget(self, action: #selector(tapPlayButton), for: .touchUpInside)
        
        menuStackView.axis = .horizontal
        menuStackView.alignment = .center
        menuStackView.distribution = .equalSpacing
        menuStackView.spacing = 20
        
        menuStackView.snp.makeConstraints {
            $0.top.equalTo(baseStackView)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
        [tvButton, movieButton, categoryButton].forEach {
            menuStackView.addArrangedSubview($0)
            $0.setTitleColor(.white, for: .normal)
            $0.layer.shadowColor = UIColor.black.cgColor
            $0.layer.shadowOpacity = 1
            $0.layer.shadowRadius = 3
        }
        
        tvButton.setTitle("TV 프로그램", for: .normal)
        movieButton.setTitle("영화", for: .normal)
        categoryButton.setTitle("카테고리", for: .normal)
        
        tvButton.addTarget(self, action: #selector(tapTVButton), for: .touchUpInside)
        movieButton.addTarget(self, action: #selector(tapMovieButton), for: .touchUpInside)
        categoryButton.addTarget(self, action: #selector(tapCategotyButton), for: .touchUpInside)
    }
    
    @objc func tapTVButton(sender: UIButton!) {
        print("TEST: TVButton tapped")
    }
    
    @objc func tapMovieButton(sender: UIButton!) {
        print("TEST: MovieButton tapped")
    }
    
    @objc func tapCategotyButton(sender: UIButton!) {
        print("TEST: CategoryButton tapped")
    }
    
    @objc func tapPlusButton(sender: UIButton!) {
        print("TEST: PlusButton tapped")
    }
    
    @objc func tapPlayButton(sender: UIButton!) {
        print("TEST: PlayButton tapped")
    }
    
    @objc func tapInfoButton(sender: UIButton!) {
        print("TEST: InfoButton tapped")
    }
}
