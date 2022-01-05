//
//  CommitPostModel.swift
//  SeSACFarm
//
//  Created by 신상원 on 2022/01/05.
//

import Foundation

class CommitPostModel {
    
    var postID = Observable(0)
    var text = Observable("")
    
    func fetchCommitPost(completion: @escaping () -> Void) {
        APIService.commitPost(postID: postID.value, text: text.value) { board, error in
            guard let board = board else {
                return
            }
            print("게시글 수정 완료")
            completion()
        }
    }
}
