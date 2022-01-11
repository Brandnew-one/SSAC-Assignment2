//
//  SignupViewController.swift
//  SeSACFarm
//
//  Created by 신상원 on 2022/01/03.
//

import RxCocoa
import RxSwift
import SnapKit
import UIKit

class SignupViewController: UIViewController {
    
    let signupView = SignupView()
    var signupViewModel = SignupViewModel()
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
        bindUI()
        
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
        signupViewModel.fetchSignup(username: signupViewModel.username.value, email: signupViewModel.email.value, password: signupViewModel.password.value) {
            DispatchQueue.main.async {
                if !self.signupViewModel.errorModel.value {
                    let vc = LoginViewController()
                    vc.title = "새싹농장 로그인하기"
                    self.navigationController?.pushViewController(vc, animated: true)
                } else { //회원가입 실패 경우에 대한 메시지
                    print("회원가입 실패")
                    self.failAlert(text: "회원가입") {
                        print("회원가입 실패 얼럿")
                    }
                }
            }
        }
    }
    
    
    func setup() {
        view.addSubview(signupView)
        signupView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func bindUI() {
        
        let emailInOb = signupView.emailTextField.rx.text.orEmpty.asObservable()
        let passWordInOb = signupView.passwordTextField.rx.text.orEmpty.asObservable()
        let confirmInOb =  signupView.confirmTextField.rx.text.orEmpty.asObservable()

        let emailValidOb = emailInOb.map(checkEmailValid)
        emailValidOb.subscribe { b in
            print(b)
        } onError: { err in
            print("err: \(err)")
        } onCompleted: {
            print("completed")
        } onDisposed: {
            print("disposed")
        }
        .disposed(by: disposeBag)
        
        Observable.combineLatest(emailValidOb, passWordInOb, confirmInOb) { s1, s2, s3 in
            return s1 && (s2 == s3) && (s2 != "")
        }
        .subscribe { b in
            print(b)
            if b {
                self.signupView.signupButton.isEnabled = b
                self.signupView.signupButton.backgroundColor = .systemGreen
            } else {
                self.signupView.signupButton.isEnabled = b
                self.signupView.signupButton.backgroundColor = .systemGray
            }
        } onError: { err in
            print("err : \(err.localizedDescription)")
        } onCompleted: {
            print("completed")
        } onDisposed: {
            print("disposed")
        }
    }
    
    func checkEmailValid(_ email: String) -> Bool {
        return email.contains("@") && email.contains(".")
    }
    
    
}
