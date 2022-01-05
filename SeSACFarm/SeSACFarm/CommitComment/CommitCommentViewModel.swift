//
//  CommitCommentViewModel.swift
//  SeSACFarm
//
//  Created by 신상원 on 2022/01/05.
//

import Foundation

class CommitCommentViewModel {
    
    var userID = Observable(0)
    var postID = Observable(0)
    var commentID = Observable(0)
    var comment = Observable("")
    
    func fetchCommitComment(completion: @escaping () -> Void) {
        APIService.commitComment(commentID: commentID.value, postID: postID.value, comment: comment.value) { comment, error in
            guard let comment = comment else {
                return
            }
            completion()
        }
    }
}
