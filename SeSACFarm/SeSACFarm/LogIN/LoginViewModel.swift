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
    
    func fetchLogin(username: String, password: String, completion: @escaping () -> Void) {
        APIService.login(username: username, password: password) { userData, error in
            guard let userData = userData else {
                print("Login 통신에 실패했읍니다.")
                self.errorModel.value = true
                return
            }
            print("Login Success")
//            print(userData)
            UserDefaults.standard.set(userData.jwt, forKey: "token")
            UserDefaults.standard.set(userData.user.id, forKey: "userID")
            UserDefaults.standard.set(userData.user.email, forKey: "userEmail")
            completion()
        }
    }
}

extension LoginViewModel {
//    func fetchAPI() {
//        fetchLogin(username: username.value, password: password.value)
//    }
}
