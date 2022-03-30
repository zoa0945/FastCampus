//
//  AppViewController.swift
//  AppStoreSample
//
//  Created by Mac on 2022/03/30.
//

import UIKit
import SnapKit

class AppViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationController()
    }
}

extension AppViewController {
    func setupNavigationController() {
        navigationItem.title = "앱"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
