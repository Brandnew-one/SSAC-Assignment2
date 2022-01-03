//
//  APIService.swift
//  SeSACFarm
//
//  Created by 신상원 on 2022/01/03.
//

import Foundation

enum APIError {
    case failed
    case noData
    case errorCode
    case decodeFail
}

class APIService {
    
    //POST 수업시간에 배운 반복 내용 줄이는거 적용하기!
    static func signup(username: String, email: String, password: String, completion: @escaping (Sign?,APIError?) -> Void) {
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
                    completion(nil, .errorCode)
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
                    completion(nil, .errorCode)
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let userData = try decoder.decode(Login.self, from: data)
                    completion(userData, nil)
                } catch {
                    completion(nil, .decodeFail)
                }
            }
        }.resume()
    }
    
    static func boards(completion: @escaping (Boards?,APIError?) -> Void) {
        let url = URL(string: "http://test.monocoding.com:1231/posts")!
        let token = UserDefaults.standard.string(forKey: "token")!
        print(token)
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
                    completion(nil, .errorCode)
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
    
}
