//
//  AddCommentViewModel.swift
//  SeSACFarm
//
//  Created by 신상원 on 2022/01/05.
//

import Foundation

class AddCommentViewModel {
    
    var textComment = Observable("")
    var postID = Observable(0)
    
    func fetchAddComment(comment: String, post: Int, completion: @escaping () -> Void) {
        APIService.addComment(comment: comment, post: post) { comment, error in
            guard let comment = comment else {
                return
            }
            print("코멘트 작성 완료")
            completion()
        }
    }
}
