//
//  LoginViewController.swift
//  SeSACFarm
//
//  Created by 신상원 on 2022/01/03.
//

import SnapKit
import UIKit

class LoginViewController: UIViewController {
    
    let loginView = LoginView()
    var loginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
        
        print(UserDefaults.standard.string(forKey: "userEmail")!)
        
        loginViewModel.username.value = UserDefaults.standard.string(forKey: "userEmail") ?? ""
        loginView.nicknameTextField.text = UserDefaults.standard.string(forKey: "userEmail") ?? ""
        
        loginViewModel.username.bind { text in
            self.loginView.nicknameTextField.text = text
        }
        loginViewModel.password.bind { text in
            self.loginView.passwordTextField.text = text
        }
        
        loginView.nicknameTextField.addTarget(self, action: #selector(usernameTextFieldDidChange(_:)), for: .editingChanged)
        loginView.passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange(_:)), for: .editingChanged)
        loginView.signupButton.addTarget(self, action: #selector(signupButtonClicked), for: .touchUpInside)
    }
    
    @objc
    func usernameTextFieldDidChange(_ textfield: UITextField) {
        loginViewModel.username.value = textfield.text ?? ""
    }
    
    @objc
    func passwordTextFieldDidChange(_ textfield: UITextField) {
        loginViewModel.password.value = textfield.text ?? ""
    }
    
    @objc
    func signupButtonClicked() {
        print("로그인중!!")
        print(loginViewModel.username.value)
        print(loginViewModel.password.value)
        loginViewModel.fetchLogin(username: loginViewModel.username.value, password: loginViewModel.password.value) {

            DispatchQueue.main.async {
                if !self.loginViewModel.errorModel.value {
                    //로그인을 하면 루트뷰를 아예 바꿔줌
                    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                    windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: BoardsViewController())
                    windowScene.windows.first?.makeKeyAndVisible()
                } else { //실패한 경우 얼럿이나, 토스메시지 추가하기!
                    print("로그인 실패")
                    self.failAlert(text: "로그인") {
                        print("로그인 실패 얼럿")
                    }
                }
            }
        }
    }
    
    func setup() {
        view.addSubview(loginView)
        loginView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}
