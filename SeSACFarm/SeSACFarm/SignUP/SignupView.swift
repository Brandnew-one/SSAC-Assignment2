//
//  SignupView.swift
//  SeSACFarm
//
//  Created by 신상원 on 2022/01/03.
//

import SnapKit
import UIKit

class SignupView: UIView {
    
    var emailTextField = UITextField()
    var nicknameTextField = UITextField()
    var passwordTextField = UITextField()
    var confirmTextField = UITextField()
    var signupButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupView() {
        [emailTextField, nicknameTextField, passwordTextField, confirmTextField, signupButton].forEach {
            self.addSubview($0)
            $0.backgroundColor = .white
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 10
        }
        emailTextField.placeholder = "  이메일 주소"
        emailTextField.layer.borderColor = CGColor.init(red: 0, green: 40, blue: 0, alpha: 1)
        emailTextField.layer.borderWidth = 1
        
        nicknameTextField.placeholder = "  닉네임"
        nicknameTextField.layer.borderColor = CGColor.init(red: 0, green: 40, blue: 0, alpha: 1)
        nicknameTextField.layer.borderWidth = 1
        
        passwordTextField.placeholder = "  비밀번호"
        passwordTextField.layer.borderColor = CGColor.init(red: 0, green: 40, blue: 0, alpha: 1)
        passwordTextField.layer.borderWidth = 1
        passwordTextField.isSecureTextEntry = true
        
        confirmTextField.placeholder = "  비밀번호 확인"
        confirmTextField.layer.borderColor = CGColor.init(red: 0, green: 40, blue: 0, alpha: 1)
        confirmTextField.layer.borderWidth = 1
        confirmTextField.isSecureTextEntry = true
        
        signupButton.isEnabled = false
        signupButton.backgroundColor = .systemGray
        signupButton.setTitle("가입하기", for: .disabled)
        signupButton.setTitle("시작하기", for: .normal)
    }
    
    func setupConstraints() {
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().offset(-18)
            make.height.equalTo(40)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(18)
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().offset(-18)
            make.height.equalTo(40)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom).offset(18)
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().offset(-18)
            make.height.equalTo(40)
        }
        
        confirmTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(18)
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().offset(-18)
            make.height.equalTo(40)
        }
        
        signupButton.snp.makeConstraints { make in
            make.top.equalTo(confirmTextField.snp.bottom).offset(18)
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().offset(-18)
            make.height.equalTo(40)
        }
    }
}
