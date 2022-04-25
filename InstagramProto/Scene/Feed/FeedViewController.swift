//
//  FeedViewController.swift
//  InstagramProto
//
//  Created by Mac on 2022/04/18.
//

import UIKit
import SnapKit

class FeedViewController: UIViewController {
    private lazy var feedTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = .none
        
        tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: "FeedTableViewCell")
        
        tableView.dataSource = self
        
        return tableView
    }()
    
    private let imagePickerController: UIImagePickerController = {
        let pickerController = UIImagePickerController()
        pickerController.allowsEditing = true
        pickerController.sourceType = .photoLibrary
        
        return pickerController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupNavigationBar()
        setupTableView()
    }
}

extension FeedViewController {
    func setupNavigationBar() {
        navigationItem.title = "Instagram"
        let uploadButton = UIBarButtonItem(
            image: UIImage(systemName: "plus.app"),
            style: .plain,
            target: self,
            action: #selector(didTapUploadButton)
        )
        navigationItem.rightBarButtonItem = uploadButton
    }
    
    @objc func didTapUploadButton() {
        present(imagePickerController, animated: true)
    }
    
    func setupTableView() {
        view.addSubview(feedTableView)
        feedTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension FeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTableViewCell", for: indexPath) as? FeedTableViewCell else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        cell.setup()
        
        return cell
    }
}
