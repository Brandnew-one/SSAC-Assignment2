//
//  SignupViewController.swift
//  SeSACFarm
//
//  Created by 신상원 on 2022/01/03.
//

import SnapKit
import UIKit

class SignupViewController: UIViewController {
    
    let signupView = SignupView()
    var signupViewModel = SignupViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
//        checkPassword()
        
        signupViewModel.username.bind { text in
            self.signupView.nicknameTextField.text = text
        }
        signupViewModel.email.bind { text in
            self.signupView.emailTextField.text = text
        }
        signupViewModel.password.bind { text in
            self.signupView.passwordTextField.text = text
        }
        
        signupView.nicknameTextField.addTarget(self, action: #selector(usernameTextFieldDidChange(_:)), for: .editingChanged)
        signupView.emailTextField.addTarget(self, action: #selector(usermailTextFieldDidChange(_:)), for: .editingChanged)
        signupView.passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange(_:)), for: .editingChanged)
        signupView.signupButton.addTarget(self, action: #selector(signupButtonClicked), for: .touchUpInside)
    }
    
    @objc
    func usernameTextFieldDidChange(_ textfield: UITextField) {
        signupViewModel.username.value = textfield.text ?? ""
    }
    
    @objc
    func usermailTextFieldDidChange(_ textfield: UITextField) {
        signupViewModel.email.value = textfield.text ?? ""
    }
    
    @objc
    func passwordTextFieldDidChange(_ textfield: UITextField) {
        signupViewModel.password.value = textfield.text ?? ""
    }
    
    @objc
    func signupButtonClicked() {
        print("회원가입중!!")
        print(signupViewModel.username.value)
        print(signupViewModel.email.value)
        print(signupViewModel.password.value)
        DispatchQueue.main.async {
            //회원가입 성공 메시지 추가
            if !self.signupViewModel.errorModel.value {
                let vc = LoginViewController()
                vc.title = "새싹농장 로그인하기"
                self.navigationController?.pushViewController(vc, animated: true)
            } else { //회원가입 실패 경우에 대한 메시지
                print("회원가입 실패")
            }
        }
    }
    
    
    func setup() {
        view.addSubview(signupView)
        signupView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func checkPassword() {
        guard let password = signupView.passwordTextField.text else { return }
        guard let confirm = signupView.confirmTextField.text else { return }
        if password == confirm {
            signupView.signupButton.isEnabled = true
        } else {
            signupView.signupButton.isEnabled = false
        }
    }
    
}
