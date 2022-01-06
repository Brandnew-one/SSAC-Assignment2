//
//  APIService.swift
//  SeSACFarm
//
//  Created by 신상원 on 2022/01/03.
//

import Foundation

//Endpoint 로 분리해서 중복 줄이기!
enum APIError {
    case failed
    case noData
    case errorCode
    case errorToken
    case decodeFail
}

class APIService {
    
    //POST 수업시간에 배운 반복 내용 줄이는거 적용하기!
    static func signup(username: String, email: String, password: String, completion: @escaping (Sign?,APIError?) -> Void) {
        print("Fetch Signup")
        let url = URL(string: "http://test.monocoding.com:1231/auth/local/register")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = "username=\(username)&email=\(email)&password=\(password)".data(using: .utf8, allowLossyConversion: false)
        URLSession.shared.dataTask(with: request) { data, response, error in
            //옵셔널 바인딩을 통해서 nil값이 아니라는것은 오류를 의미
            DispatchQueue.main.async {
                if let error = error {
                    completion(nil, .failed)
                    return
                }
                //data 가 nil 이면 오류를 의미하니까 바로 종료
                guard let data = data else {
                    completion(nil, .noData)
                    return
                }
                
                // URLResponse 로 캐스팅 되지 않으면 오류
                guard let response = response as? HTTPURLResponse else {
                    completion(nil, .failed)
                    return
                }
                // 200번대 statusCode 가 아니라면 오류
                if !(200...299).contains(response.statusCode) {
                    if response.statusCode == 401 {
                        completion(nil, .errorToken)
                    } else {
                        completion(nil, .errorCode)
                    }
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let userData = try decoder.decode(Sign.self, from: data)
                    completion(userData, nil)
                } catch {
                    completion(nil, .decodeFail)
                }
            }
            
        }.resume()
    }
    
    static func login(username: String, password: String, completion: @escaping (Login?,APIError?) -> Void) {
        print("Fetch Login")
        let url = URL(string: "http://test.monocoding.com:1231/auth/local")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = "identifier=\(username)&password=\(password)".data(using: .utf8, allowLossyConversion: false)
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                //옵셔널 바인딩을 통해서 nil값이 아니라는것은 오류를 의미
                if let error = error {
                    completion(nil, .failed)
                    return
                }
                //data 가 nil 이면 오류를 의미하니까 바로 종료
                guard let data = data else {
                    print("DATA ERROR")
                    completion(nil, .noData)
                    return
                }
                
                // URLResponse 로 캐스팅 되지 않으면 오류
                guard let response = response as? HTTPURLResponse else {
                    print("RESPONSE ERROR")
                    completion(nil, .failed)
                    return
                }
                // 200번대 statusCode 가 아니라면 오류
                if !(200...299).contains(response.statusCode) {
                    if response.statusCode == 401 {
                        completion(nil, .errorToken)
                    } else {
                        completion(nil, .errorCode)
                    }
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let userData = try decoder.decode(Login.self, from: data)
                    completion(userData, nil)
                } catch {
                    print("DECODE ERROR")
                    completion(nil, .decodeFail)
                }
            }
        }.resume()
    }
    
    static func boards(completion: @escaping (Boards?,APIError?) -> Void) {
        let url = URL(string: "http://test.monocoding.com:1231/posts?_sort=created_at%3Adesc")!
        let token = UserDefaults.standard.string(forKey: "token")!
//        print(token)
        var request = URLRequest(url: url)
        request.setValue("bearer " + token, forHTTPHeaderField: "authorization")
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                //옵셔널 바인딩을 통해서 nil값이 아니라는것은 오류를 의미
                if let error = error {
                    completion(nil, .failed)
                    return
                }
                //data 가 nil 이면 오류를 의미하니까 바로 종료
                guard let data = data else {
                    completion(nil, .noData)
                    return
                }
                
                // URLResponse 로 캐스팅 되지 않으면 오류
                guard let response = response as? HTTPURLResponse else {
                    completion(nil, .failed)
                    return
                }
                // 200번대 statusCode 가 아니라면 오류
                if !(200...299).contains(response.statusCode) {
                    if response.statusCode == 401 {
                        completion(nil, .errorToken)
                    } else {
                        completion(nil, .errorCode)
                    }
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let userData = try decoder.decode(Boards.self, from: data)
                    completion(userData, nil)
                } catch {
                    completion(nil, .decodeFail)
                }
            }
        }.resume()
    }
    
    static func addPost(text: String, completion: @escaping (Board?, APIError?) -> Void) {
        let url = URL(string: "http://test.monocoding.com:1231/posts")!
        let token = UserDefaults.standard.string(forKey: "token")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = "text=\(text)".data(using: .utf8, allowLossyConversion: false)
        request.setValue("bearer " + token, forHTTPHeaderField: "authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                //옵셔널 바인딩을 통해서 nil값이 아니라는것은 오류를 의미
                if let error = error {
                    completion(nil, .failed)
                    return
                }
                //data 가 nil 이면 오류를 의미하니까 바로 종료
                guard let data = data else {
                    completion(nil, .noData)
                    return
                }
                
                // URLResponse 로 캐스팅 되지 않으면 오류
                guard let response = response as? HTTPURLResponse else {
                    completion(nil, .failed)
                    return
                }
                // 200번대 statusCode 가 아니라면 오류
                if !(200...299).contains(response.statusCode) {
                    if response.statusCode == 401 {
                        completion(nil, .errorToken)
                    } else {
                        completion(nil, .errorCode)
                    }
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let userData = try decoder.decode(Board.self, from: data)
                    completion(userData, nil)
                } catch {
                    completion(nil, .decodeFail)
                }
            }
        }.resume()
    }
    
    //QueryItem 사용하지 않은 상태
    static func inquireComment(id: Int, completion: @escaping (CommentFind?, APIError?) -> Void) {
        let url = URL(string: "http://test.monocoding.com:1231/comments?post=\(id)")!
        let token = UserDefaults.standard.string(forKey: "token")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("bearer " + token, forHTTPHeaderField: "authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                //옵셔널 바인딩을 통해서 nil값이 아니라는것은 오류를 의미
                if let error = error {
                    completion(nil, .failed)
                    return
                }
                //data 가 nil 이면 오류를 의미하니까 바로 종료
                guard let data = data else {
                    completion(nil, .noData)
                    return
                }
                
                // URLResponse 로 캐스팅 되지 않으면 오류
                guard let response = response as? HTTPURLResponse else {
                    completion(nil, .failed)
                    return
                }
                // 200번대 statusCode 가 아니라면 오류
                if !(200...299).contains(response.statusCode) {
                    if response.statusCode == 401 {
                        completion(nil, .errorToken)
                    } else {
                        completion(nil, .errorCode)
                    }
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let userData = try decoder.decode(CommentFind.self, from: data)
                    completion(userData, nil)
                } catch {
                    completion(nil, .decodeFail)
                }
            }
        }.resume()
    }
    
    static func addComment(comment: String, post: Int, completion: @escaping (AddComment?, APIError?) -> Void) {
        let url = URL(string: "http://test.monocoding.com:1231/comments")!
        let token = UserDefaults.standard.string(forKey: "token")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = "comment=\(comment)&post=\(post)".data(using: .utf8, allowLossyConversion: false)
        request.setValue("bearer " + token, forHTTPHeaderField: "authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                //옵셔널 바인딩을 통해서 nil값이 아니라는것은 오류를 의미
                if let error = error {
                    completion(nil, .failed)
                    return
                }
                //data 가 nil 이면 오류를 의미하니까 바로 종료
                guard let data = data else {
                    completion(nil, .noData)
                    return
                }
                
                // URLResponse 로 캐스팅 되지 않으면 오류
                guard let response = response as? HTTPURLResponse else {
                    completion(nil, .failed)
                    return
                }
                // 200번대 statusCode 가 아니라면 오류
                if !(200...299).contains(response.statusCode) {
                    if response.statusCode == 401 {
                        completion(nil, .errorToken)
                    } else {
                        completion(nil, .errorCode)
                    }
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let userData = try decoder.decode(AddComment.self, from: data)
                    completion(userData, nil)
                } catch {
                    completion(nil, .decodeFail)
                }
            }
        }.resume()
    }
    
    static func commitComment(commentID: Int, postID: Int, comment: String, completion: @escaping (AddComment?, APIError?) -> Void) {
        let url = URL(string: "http://test.monocoding.com:1231/comments/\(commentID)")!
        let token = UserDefaults.standard.string(forKey: "token")!
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.httpBody = "comment=\(comment)&post=\(postID)".data(using: .utf8, allowLossyConversion: false)
        request.setValue("bearer " + token, forHTTPHeaderField: "authorization")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type") //수정은 써줘야 한다!!
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                //옵셔널 바인딩을 통해서 nil값이 아니라는것은 오류를 의미
                if let error = error {
                    completion(nil, .failed)
                    return
                }
                //data 가 nil 이면 오류를 의미하니까 바로 종료
                guard let data = data else {
                    completion(nil, .noData)
                    return
                }
                
                // URLResponse 로 캐스팅 되지 않으면 오류
                guard let response = response as? HTTPURLResponse else {
                    completion(nil, .failed)
                    return
                }
                // 200번대 statusCode 가 아니라면 오류
                if !(200...299).contains(response.statusCode) {
                    if response.statusCode == 401 {
                        completion(nil, .errorToken)
                    } else {
                        completion(nil, .errorCode)
                    }
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let userData = try decoder.decode(AddComment.self, from: data)
                    completion(userData, nil)
                } catch {
                    completion(nil, .decodeFail)
                }
            }
        }.resume()
    }
    
    static func deleteComment(commentID: Int, completion: @escaping (AddComment?, APIError?) -> Void) {
        let url = URL(string: "http://test.monocoding.com:1231/comments/\(commentID)")!
        let token = UserDefaults.standard.string(forKey: "token")!
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("bearer " + token, forHTTPHeaderField: "authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                //옵셔널 바인딩을 통해서 nil값이 아니라는것은 오류를 의미
                if let error = error {
                    completion(nil, .failed)
                    return
                }
                //data 가 nil 이면 오류를 의미하니까 바로 종료
                guard let data = data else {
                    completion(nil, .noData)
                    return
                }
                
                // URLResponse 로 캐스팅 되지 않으면 오류
                guard let response = response as? HTTPURLResponse else {
                    completion(nil, .failed)
                    return
                }
                // 200번대 statusCode 가 아니라면 오류
                if !(200...299).contains(response.statusCode) {
                    if response.statusCode == 401 {
                        completion(nil, .errorToken)
                    } else {
                        completion(nil, .errorCode)
                    }
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let userData = try decoder.decode(AddComment.self, from: data)
                    completion(userData, nil)
                } catch {
                    completion(nil, .decodeFail)
                }
            }
        }.resume()
    }
    
    static func commitPost(postID: Int, text: String, completion: @escaping (Board?, APIError? ) -> Void) {
        let url = URL(string: "http://test.monocoding.com:1231/posts/\(postID)")!
        let token = UserDefaults.standard.string(forKey: "token")!
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.httpBody = "text=\(text)".data(using: .utf8, allowLossyConversion: false)
        request.setValue("bearer " + token, forHTTPHeaderField: "authorization")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type") //수정은 써줘야 한다!!
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                //옵셔널 바인딩을 통해서 nil값이 아니라는것은 오류를 의미
                if let error = error {
                    completion(nil, .failed)
                    return
                }
                //data 가 nil 이면 오류를 의미하니까 바로 종료
                guard let data = data else {
                    completion(nil, .noData)
                    return
                }
                
                // URLResponse 로 캐스팅 되지 않으면 오류
                guard let response = response as? HTTPURLResponse else {
                    completion(nil, .failed)
                    return
                }
                // 200번대 statusCode 가 아니라면 오류
                if !(200...299).contains(response.statusCode) {
                    if response.statusCode == 401 {
                        completion(nil, .errorToken)
                    } else {
                        completion(nil, .errorCode)
                    }
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let userData = try decoder.decode(Board.self, from: data)
                    completion(userData, nil)
                } catch {
                    completion(nil, .decodeFail)
                }
            }
        }.resume()
    }
    
    static func deletePost(postID: Int, completion: @escaping (Board?, APIError?) -> Void) {
        let url = URL(string: "http://test.monocoding.com:1231/posts/\(postID)")!
        let token = UserDefaults.standard.string(forKey: "token")!
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("bearer " + token, forHTTPHeaderField: "authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                //옵셔널 바인딩을 통해서 nil값이 아니라는것은 오류를 의미
                if let error = error {
                    completion(nil, .failed)
                    return
                }
                //data 가 nil 이면 오류를 의미하니까 바로 종료
                guard let data = data else {
                    completion(nil, .noData)
                    return
                }
                
                // URLResponse 로 캐스팅 되지 않으면 오류
                guard let response = response as? HTTPURLResponse else {
                    completion(nil, .failed)
                    return
                }
                // 200번대 statusCode 가 아니라면 오류
                if !(200...299).contains(response.statusCode) {
                    if response.statusCode == 401 {
                        completion(nil, .errorToken)
                    } else {
                        completion(nil, .errorCode)
                    }
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let userData = try decoder.decode(Board.self, from: data)
                    completion(userData, nil)
                } catch {
                    completion(nil, .decodeFail)
                }
            }
        }.resume()
    }
    
    static func findPost(postID: Int, completion: @escaping (Board?, APIError?) -> Void) {
        let url = URL(string: "http://test.monocoding.com:1231/posts/\(postID)")!
        let token = UserDefaults.standard.string(forKey: "token")!
//        print(token)
        var request = URLRequest(url: url)
        request.setValue("bearer " + token, forHTTPHeaderField: "authorization")
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                //옵셔널 바인딩을 통해서 nil값이 아니라는것은 오류를 의미
                if let error = error {
                    completion(nil, .failed)
                    return
                }
                //data 가 nil 이면 오류를 의미하니까 바로 종료
                guard let data = data else {
                    completion(nil, .noData)
                    return
                }
                
                // URLResponse 로 캐스팅 되지 않으면 오류
                guard let response = response as? HTTPURLResponse else {
                    completion(nil, .failed)
                    return
                }
                // 200번대 statusCode 가 아니라면 오류
                if !(200...299).contains(response.statusCode) {
                    if response.statusCode == 401 {
                        completion(nil, .errorToken)
                    } else {
                        completion(nil, .errorCode)
                    }
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let userData = try decoder.decode(Board.self, from: data)
                    completion(userData, nil)
                } catch {
                    completion(nil, .decodeFail)
                }
            }
        }.resume()
    }
    
}
