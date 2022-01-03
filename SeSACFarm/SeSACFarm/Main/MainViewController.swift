//
//  MainViewController.swift
//  SeSACFarm
//
//  Created by 신상원 on 2022/01/03.
//

import SnapKit
import UIKit

class MainViewController: UIViewController {
    
    let mainView = MainView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setup()
        mainView.startButton.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
        mainView.loginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
    }
    
    @objc
    func startButtonClicked() {
        let vc = SignupViewController()
        vc.title = "새싹농장 가입하기"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc
    func loginButtonClicked() {
        let vc = LoginViewController()
        vc.title = "새싹농장 로그인하기"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func setup() {
        view.addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
    }
    
}
