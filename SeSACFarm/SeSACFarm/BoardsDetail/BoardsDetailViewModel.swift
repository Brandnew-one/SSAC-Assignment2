//
//  BoardsDetailViewModel.swift
//  SeSACFarm
//
//  Created by 신상원 on 2022/01/06.
//

import Foundation

class BoardsDetailViewModel {
    
    var postID = Observable2(0)
    var boardsDetail = Observable2(Board(id: 0, text: "", user: BoardUser(id: 0, username: "", email: "", provider: Provider.local, confirmed: false, blocked: nil, role: 0, createdAt: "", updatedAt: ""), createdAt: "", updatedAt: "", comments: []))
    
    func fetchSearchPost(completion: @escaping () -> Void) {
        APIService.findPost(postID: postID.value) { board, error in
            guard let board = board else {
                return
            }
            self.boardsDetail.value = board
            completion()
        }
    }
    
}
