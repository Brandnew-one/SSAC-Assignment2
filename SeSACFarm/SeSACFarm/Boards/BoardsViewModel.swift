//
//  BoardsViewModel.swift
//  SeSACFarm
//
//  Created by 신상원 on 2022/01/03.
//

import Foundation

class BoardsViewModel {
    
    var boards = Observable(Boards())
    var boardsDetail = Observable(Board(id: 0, text: "", user: BoardUser(id: 0, username: "", email: "", provider: Provider.local, confirmed: false, blocked: nil, role: 0, createdAt: "", updatedAt: ""), createdAt: "", updatedAt: "", comments: []))
    
    func fetchBoards(completion: @escaping () -> Void) {
        APIService.boards() { userData, error in
            guard let userData = userData else {
                return
            }
//            print(userData)
            self.boards.value = userData
            completion()
        }
    }
}

extension BoardsViewModel {
    var numberOfRowInSection: Int {
        return boards.value.count
    }
    
    func cellForRowAt(at indexPath: IndexPath) -> Board {
        return boards.value[indexPath.row]
    }
}
