//
//  MainViewController.swift
//  18.MarketUpload
//
//  Created by zoa0945 on 2022/09/27.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

// MVC vs MVVM
// MVC: Model, View, Controller 각각의 객체가 앱에서 수행하는
// 역할을 정의하고 이들이 서로 통신하는 방식을 정의하게 됨
// 각각의 객체는 추상적으로 다른 유형과 분리되고 이러한 경계를 넘어 다른 유형의 객체와 통신하게 됨
// 재사용 가능성이 높고 인터페이스가 더 잘 정의됨
// 쉽게 확장 가능함
// 그러나 CocoaFramework의 경우 UIViewController가 View와 Controller의 역할을 같이 하기 때문에
// 이 둘을 완전히 분리하기 어려움
// UIViewController도 자신의 View를 가지고 있어 온전한 Controller의 멱할만 하지 못함
// 앱의 크키가 커질수록 ViewController의 크기가 필연적으로 커지게 됨

// MVVM: Model, View, ViewModel로 이루어져 있음
// View: UIView, UIViewController
// View는 각자의 ViewModel을 소유하게 됨
// View와 ViewModel은 Binding되어 데이터, 사용자 액션을 주고 받게 됨
// ViewModel은 자신의 Model을 가질 수 있음 Model을 통해 비즈니스 로직을 처리하게 됨

class MainViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    let tableView = UITableView()
    let submitButton = UIBarButtonItem()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(viewModel: MainViewModel) {
        
    }
    
    private func attribute() {
        title = "중고거래 글쓰기"
        view.backgroundColor = .systemBackground
        
        submitButton.title = "제출"
        submitButton.style = .done
        
        navigationItem.setRightBarButton(submitButton, animated: true)
        
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = .singleLine
        tableView.tableFooterView = UIView()
        
        tableView.register(TitleTextFieldCell.self, forCellReuseIdentifier: "TitleTextFieldCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CategoryListCell")
        tableView.register(PriceTextFieldCell.self, forCellReuseIdentifier: "PriceTextFieldCell")
    }
    
    private func layout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

typealias Alert = (title: String, message: String?)
extension Reactive where Base: MainViewController {
    var setAlert: Binder<Alert> {
        return Binder(base) { base, data in
            let alertController = UIAlertController(title: data.title, message: data.message, preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .cancel)
            alertController.addAction(action)
            base.present(alertController, animated: true)
        }
    }
}
