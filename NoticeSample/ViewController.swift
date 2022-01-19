//
//  ViewController.swift
//  NoticeSample
//
//  Created by Mac on 2022/01/17.
//

import UIKit
import FirebaseRemoteConfig
import FirebaseAnalytics

class ViewController: UIViewController {
    
    var remoteConfig: RemoteConfig?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        remoteConfig = RemoteConfig.remoteConfig()
        
        let setting = RemoteConfigSettings()
        
        // 실시간으로 변화되는 것을 테스트하기 쉽게 간격을 최소화
        setting.minimumFetchInterval = 0
        
        remoteConfig?.configSettings = setting
        remoteConfig?.setDefaults(fromPlist: "RemoteConfigDefaults")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getNotice()
    }
}

// RemoteConfig
extension ViewController {
    func getNotice() {
        guard let remoteConfig = remoteConfig else { return }
        
        remoteConfig.fetch { [weak self] status, _ in
            if status == .success {
                remoteConfig.activate(completion: nil)
            } else {
                print("ERROR: Config not fetch")
            }
            
            guard let self = self else { return }
            if !self.isNoticeHidden(remoteConfig: remoteConfig) {
                let noticeVC = NoticeViewController(nibName: "NoticeViewController", bundle: nil)
                noticeVC.modalPresentationStyle = .custom
                noticeVC.modalTransitionStyle = .crossDissolve
                
                let title = (remoteConfig["title"].stringValue ?? "").replacingOccurrences(of: "\\n", with: "\n")
                let detail = (remoteConfig["detail"].stringValue ?? "").replacingOccurrences(of: "\\n", with: "\n")
                let date = (remoteConfig["date"].stringValue ?? "").replacingOccurrences(of: "\\n", with: "\n")
                
                noticeVC.noticeContents = (title: title, detail: detail, date: date)
                self.present(noticeVC, animated: true, completion: nil)
            } else {
                self.showEventAlert()
            }
        }
    }
    
    func isNoticeHidden(remoteConfig: RemoteConfig) -> Bool {
        return remoteConfig["isHidden"].boolValue
    }
}


// A/B Testion
extension ViewController {
    func showEventAlert() {
        guard let remoteConfig = remoteConfig else { return }
        
        remoteConfig.fetch { [weak self] status, _ in
            if status == .success {
                remoteConfig.activate(completion: nil)
            } else {
                print("ERROR: Config not fetch")
            }
            
            let message = remoteConfig["message"].stringValue ?? ""
            
            let confirmAction = UIAlertAction(title: "확인하기", style: .default) { _ in
                // Google Analytics
                Analytics.logEvent("promotion_alert", parameters: nil)
            }
            
            let canccelAction = UIAlertAction(title: "취소", style: .default, handler: nil)
            let alertController = UIAlertController(title: "깜짝이벤트", message: message, preferredStyle: .alert)
            
            alertController.addAction(confirmAction)
            alertController.addAction(canccelAction)
            
            self?.present(alertController, animated: true, completion: nil)
        }
    }
}
