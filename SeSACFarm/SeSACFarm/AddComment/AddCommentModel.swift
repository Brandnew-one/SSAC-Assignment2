//
//  AddCommentModel.swift
//  SeSACFarm
//
//  Created by 신상원 on 2022/01/05.
//

import Foundation
//Model 에서 구조체 겹치거 많음 뇌에 과부화 걸려서 지금은 불가능하니 나중에 중복되는거 줄일 것!

struct AddComment: Codable {
    let id: Int
    let comment: String
    let user: AddCommentUser
    let post: AddCommentPost
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, comment, user, post
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - Post
struct AddCommentPost: Codable {
    let id: Int
    let text: String
    let user: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, text, user
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - User
struct AddCommentUser: Codable {
    let id: Int
    let username, email, provider: String
    let confirmed: Bool
    let role: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, username, email, provider, confirmed, role
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
