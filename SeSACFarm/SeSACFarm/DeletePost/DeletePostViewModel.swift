//
//  DeletePostViewModel.swift
//  SeSACFarm
//
//  Created by 신상원 on 2022/01/06.
//

import Foundation

class DeletePostViewModel {
    
    var postID = Observable2(0)
    
    func fetchDeltePost(completion: @escaping () -> Void) {
        APIService.deletePost(postID: postID.value) { board, error in
            guard let board = board else {
                return
            }
            print("게시글 삭제 성공~")
            completion()
        }
    }
    
}
