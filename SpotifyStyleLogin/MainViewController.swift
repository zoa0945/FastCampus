//
//  MainViewController.swift
//  SpotifyStyleLogin
//
//  Created by Mac on 2022/01/06.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 뒤로가기 스와이프(popgesture) 가 안되도록 설정
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func tapLogoutButton(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
