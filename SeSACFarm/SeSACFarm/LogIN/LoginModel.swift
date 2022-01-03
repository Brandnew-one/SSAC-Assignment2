//
//  LoginModel.swift
//  SeSACFarm
//
//  Created by 신상원 on 2022/01/03.
//

import Foundation

// MARK: - Login
struct Login: Codable {
    let jwt: String
    let user: LoginUser
}

// MARK: - LoginUser
struct LoginUser: Codable {
    let id: Int
    let username, email: String
}
