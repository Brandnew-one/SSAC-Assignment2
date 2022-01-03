//
//  LoginViewModel.swift
//  SeSACFarm
//
//  Created by 신상원 on 2022/01/03.
//

import Foundation

class LoginViewModel {
    
    var username = Observable("")
    var password = Observable("")
    var errorModel = Observable(false) //화면전환을 위해서 오류 발생했는지 확인용
    
    func fetchLogin(username: String, password: String) {
        APIService.login(username: username, password: password) { userData, error in
            guard let userData = userData else {
                self.errorModel.value = true
                return
            }
            print("Login Success")
            print(userData)
            UserDefaults.standard.set(userData.jwt, forKey: "token")
        }
    }
}

extension LoginViewModel {
    func fetchAPI() {
        fetchLogin(username: username.value, password: password.value)
    }
}
