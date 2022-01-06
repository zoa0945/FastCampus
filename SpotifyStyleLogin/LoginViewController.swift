//
//  LoginViewController.swift
//  SpotifyStyleLogin
//
//  Created by Mac on 2022/01/06.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailLoginButton: UIButton!
    @IBOutlet weak var googleLoginButton: UIButton!
    @IBOutlet weak var appleLoginLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        [emailLoginButton, googleLoginButton, appleLoginLogin].forEach {
            $0?.layer.borderWidth = 1
            $0?.layer.borderColor = UIColor.white.cgColor
            $0?.layer.cornerRadius = 30
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Navigation Bar 숨기기
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func tapGoogleLoginButton(_ sender: Any) {
    }
    
    @IBAction func tapAppleLoginButton(_ sender: Any) {
    }
}
