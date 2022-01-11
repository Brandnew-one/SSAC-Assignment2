//
//  AddPostViewModel.swift
//  SeSACFarm
//
//  Created by 신상원 on 2022/01/04.
//

import Foundation

class AddPostViewModel {
    
    var postText = Observable2("")
    
    //AddPost 과정 통신 값을 굳이 저장해서 우리가 사용할 필요가 없지 않을까?
    func fetchAddPost(completion: @escaping () -> Void) {
        APIService.addPost(text: postText.value) { post, error in
            guard let post = post else {
                return
            }
            print("게시글 작성 성공~")
            completion()
        }
    }
    
}
