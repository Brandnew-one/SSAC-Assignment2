//
//  DeleteViewModel.swift
//  SeSACFarm
//
//  Created by 신상원 on 2022/01/05.
//

import Foundation

class DeleteViewModel {
    
    var commentID = Observable(0)
    
    func fetchDeleteComment(completion: @escaping () -> Void) {
        APIService.deleteComment(commentID: commentID.value) { comment, error in
            guard let comment = comment else {
                return
            }
            print("삭제 성공")
            completion()
        }
    }
}
