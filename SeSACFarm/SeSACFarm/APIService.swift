//
//  APIService.swift
//  SeSACFarm
//
//  Created by 신상원 on 2022/01/03.
//

import Foundation

class APIService {
    
    static func signup(username: String, email: String, password: String, completion: @escaping (Sign?,APIError?) -> Void) {
        
        let url = Endpoint.signup.url
        var request = URLRequest(url: url)
        request.httpMethod = Method.POST.rawValue
        request.httpBody = "username=\(username)&email=\(email)&password=\(password)".data(using: .utf8, allowLossyConversion: false)
        
        URLSession.request(endpoint: request, completion: completion)
    }
    
    
    static func login(username: String, password: String, completion: @escaping (Login?,APIError?) -> Void) {
        print("Fetch Login")
        
        var url = Endpoint.login.url
        var request = URLRequest(url: url)
        request.httpMethod = Method.POST.rawValue
        request.httpBody = "identifier=\(username)&password=\(password)".data(using: .utf8, allowLossyConversion: false)
        
        URLSession.request(endpoint: request, completion: completion)
    }
    
    static func boards(completion: @escaping (Boards?,APIError?) -> Void) {
        
        var url = Endpoint.boards.url
        let token = UserDefaults.standard.string(forKey: "token")!
        var request = URLRequest(url: url)
        request.httpMethod = Method.GET.rawValue
        request.setValue("bearer " + token, forHTTPHeaderField: "authorization")
        
        URLSession.request(endpoint: request, completion: completion)
    }
    
    static func addPost(text: String, completion: @escaping (Board?, APIError?) -> Void) {
        var url = Endpoint.addPost.url
        let token = UserDefaults.standard.string(forKey: "token")!
        var request = URLRequest(url: url)
        
        request.httpMethod = Method.POST.rawValue
        request.httpBody = "text=\(text)".data(using: .utf8, allowLossyConversion: false)
        request.setValue("bearer " + token, forHTTPHeaderField: "authorization")
        
        URLSession.request(endpoint: request, completion: completion)
    }
    
    static func inquireComment(id: Int, completion: @escaping (CommentFind?, APIError?) -> Void) {
        var url = Endpoint.inquireComment(id: id).url
        let token = UserDefaults.standard.string(forKey: "token")!
        var request = URLRequest(url: url)
        
        request.httpMethod = Method.GET.rawValue
        request.setValue("bearer " + token, forHTTPHeaderField: "authorization")
        
        URLSession.request(endpoint: request, completion: completion)
    }
    
    static func addComment(comment: String, post: Int, completion: @escaping (AddComment?, APIError?) -> Void) {
        
        var url = Endpoint.addComment.url
        let token = UserDefaults.standard.string(forKey: "token")!
        var request = URLRequest(url: url)
        
        request.httpMethod = Method.POST.rawValue
        request.httpBody = "comment=\(comment)&post=\(post)".data(using: .utf8, allowLossyConversion: false)
        request.setValue("bearer " + token, forHTTPHeaderField: "authorization")
        
        URLSession.request(endpoint: request, completion: completion)
    }
    
    static func commitComment(commentID: Int, postID: Int, comment: String, completion: @escaping (AddComment?, APIError?) -> Void) {
        
        var url = Endpoint.commitComment(commentID: commentID).url
        let token = UserDefaults.standard.string(forKey: "token")!
        var request = URLRequest(url: url)
        
        request.httpMethod = Method.PUT.rawValue
        request.httpBody = "comment=\(comment)&post=\(postID)".data(using: .utf8, allowLossyConversion: false)
        request.setValue("bearer " + token, forHTTPHeaderField: "authorization")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        URLSession.request(endpoint: request, completion: completion)
    }
    
    
    static func deleteComment(commentID: Int, completion: @escaping (AddComment?, APIError?) -> Void) {
        
        var url = Endpoint.deleteComment(commentID: commentID).url
        let token = UserDefaults.standard.string(forKey: "token")!
        var request = URLRequest(url: url)
        
        request.httpMethod = Method.DELETE.rawValue
        request.setValue("bearer " + token, forHTTPHeaderField: "authorization")
        
        URLSession.request(endpoint: request, completion: completion)
    }
    
    static func commitPost(postID: Int, text: String, completion: @escaping (Board?, APIError? ) -> Void) {
        
        var url = Endpoint.commitPost(postID: postID).url
        let token = UserDefaults.standard.string(forKey: "token")!
        var request = URLRequest(url: url)
        
        request.httpMethod = Method.PUT.rawValue
        request.httpBody = "text=\(text)".data(using: .utf8, allowLossyConversion: false)
        request.setValue("bearer " + token, forHTTPHeaderField: "authorization")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        URLSession.request(endpoint: request, completion: completion)
    }
    
    static func deletePost(postID: Int, completion: @escaping (Board?, APIError?) -> Void) {
        
        var url = Endpoint.deletePost(postID: postID).url
        let token = UserDefaults.standard.string(forKey: "token")!
        var request = URLRequest(url: url)
        
        request.httpMethod = Method.DELETE.rawValue
        request.setValue("bearer " + token, forHTTPHeaderField: "authorization")
        
        URLSession.request(endpoint: request, completion: completion)
    }
    
    
    static func findPost(postID: Int, completion: @escaping (Board?, APIError?) -> Void) {
        
        var url = Endpoint.findPost(postID: postID).url
        let token = UserDefaults.standard.string(forKey: "token")!
        var request = URLRequest(url: url)
        
        request.httpMethod = Method.GET.rawValue
        request.setValue("bearer " + token, forHTTPHeaderField: "authorization")
        
        URLSession.request(endpoint: request, completion: completion)
    }
    
}
