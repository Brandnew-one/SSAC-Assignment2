//
//  EndPoint.swift
//  SeSACFarm
//
//  Created by 신상원 on 2022/01/12.
//

import Foundation

enum Method: String {
    case GET
    case POST
    case PUT
    case DELETE
}

enum APIError {
    case failed
    case noData
    case errorCode
    case errorToken
    case decodeFail
}

enum Endpoint {
    case signup //회원가입
    case login // 로그인
    case boards // 게시판
    case addPost // 게시글 쓰기
    case inquireComment(id: Int) // 특정 게시글 댓글 받아오기
    case addComment // 특정 게시글에 댓글
    case commitComment(commentID: Int) // 댓글 수정
    case deleteComment(commentID: Int) // 댓글 삭제
    case commitPost(postID: Int) // 게시글 수정
    case deletePost(postID: Int) // 게시글 삭제
    case findPost(postID: Int) // 특정 게시글 검색(특정 게시글로 들어가는 경우를 위해서)
}

extension Endpoint {
    var url: URL {
        switch self {
        case .signup: return .makeEndpoint("auth/local/register")
        case .login: return .makeEndpoint("auth/local")
        case .boards: return .makeEndpoint("posts?_sort=created_at%3Adesc")
        case .addPost: return .makeEndpoint("posts")
        case .inquireComment(id: let id): return .makeEndpoint("comments?post=\(id)")
        case .addComment: return .makeEndpoint("comments")
        case .commitComment(commentID: let commentID): return .makeEndpoint("comments/\(commentID)")
        case .deleteComment(commentID: let commentID): return .makeEndpoint("comments/\(commentID)")
        case .commitPost(postID: let postID): return .makeEndpoint("posts/\(postID)")
        case .deletePost(postID: let postID): return .makeEndpoint("posts/\(postID)")
        case .findPost(postID: let postID): return .makeEndpoint("posts/\(postID)")
        }
    }
}

extension URL {
    static let baseURL = "http://test.monocoding.com:1231/"
    
    static func makeEndpoint(_ endpoint: String) -> URL {
        URL(string: baseURL + endpoint)!
    }
}

extension URLSession {
    
    typealias Handler = (Data?, URLResponse?, Error?) -> Void
    
    @discardableResult
    func dataTask(_ endpoint: URLRequest, handler: @escaping Handler) -> URLSessionDataTask {
        let task = dataTask(with: endpoint, completionHandler: handler)
        task.resume()
        return task
    }
    
    static func request<T: Decodable>(_ session: URLSession = . shared, endpoint: URLRequest, completion: @escaping (T?, APIError?) -> Void) {
        session.dataTask(endpoint) { data, response, error in
            
            DispatchQueue.main.async {
                guard error == nil else {
                    completion(nil, .failed)
                    return
                    
                }
                guard let data = data else {
                    completion(nil, .noData)
                    return
                    
                }
                guard let response = response as? HTTPURLResponse else {
                    completion(nil, .failed)
                    return
                }
                
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
                    let userData = try decoder.decode(T.self, from: data)
                    completion(userData, nil) //성공적으로 통신에 성공한 경우
                } catch {
                    completion(nil, .decodeFail)
                }
            }
        }
    }
}
