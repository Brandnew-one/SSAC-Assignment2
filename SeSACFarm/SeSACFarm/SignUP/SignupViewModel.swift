//
//  SignupViewModel.swift
//  SeSACFarm
//
//  Created by 신상원 on 2022/01/03.
//

import Foundation

class SignupViewModel {
    
    var username = Observable2("")
    var email = Observable2("")
    var password = Observable2("")
    var errorModel = Observable2(false)
    
    //초기에는 탈출클로저 없이 화면전환을 구성하고 싶었으나 실패한 상태
    func fetchSignup(username: String, email: String, password: String, completion: @escaping () -> Void) {
        APIService.signup(username: username, email: email, password: password) { userData, error in
            guard let userData = userData else {
                print("회원가입에 실패했읍니다.")
                self.errorModel.value = true
                completion()
                return
            }
            print("Signup Success")
//            print(userData)
            UserDefaults.standard.set(userData.jwt, forKey: "token")
            completion()
        }
    }
}

extension SignupViewModel {
//    func fetchAPI() {
//        fetchSignup(username: username.value, email: email.value, password: password.value)
//    }
}
