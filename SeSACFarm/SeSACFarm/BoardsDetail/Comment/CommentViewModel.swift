//
//  CommentViewModel.swift
//  SeSACFarm
//
//  Created by 신상원 on 2022/01/04.
//

import Foundation

class CommentViewModel {
    
    var id = Observable(0)
    var comment = Observable(CommentFind())
    
    func fetchCommentFind(completion: @escaping () -> Void) {
        APIService.inquireComment(id: self.id.value) { comment, error in
            guard let comment = comment else {
                return
            }
            self.comment.value = comment
            completion()
        }
    }
    
}
