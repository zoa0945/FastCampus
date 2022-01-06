//
//  EnterEmailViewController.swift
//  SpotifyStyleLogin
//
//  Created by Mac on 2022/01/06.
//

import UIKit

class EnterEmailViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.layer.cornerRadius = 30
        loginButton.isEnabled = false
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        // 처음에 커서가 emailTextField에 위치하도록 설정
        emailTextField.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Navigation Bar 보이기
        navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func tapLoginButton(_ sender: UIButton) {
    }
    
}

extension EnterEmailViewController: UITextFieldDelegate {
    // email, password 입력이 끝나면 키보드가 내려가도록 설정
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
    // email, password 에 입력한 값이 있는지 확인 후 로그인 버튼 활성화
    func textFieldDidEndEditing(_ textField: UITextField) {
        let isEmailEmpty = emailTextField.text == ""
        let ispasswordEmpty = passwordTextField.text == ""
        if !isEmailEmpty && !ispasswordEmpty {
            loginButton.isEnabled = true
        }
    }
}
