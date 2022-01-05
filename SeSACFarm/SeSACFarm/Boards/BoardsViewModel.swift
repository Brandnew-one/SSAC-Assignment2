//
//  BoardsViewModel.swift
//  SeSACFarm
//
//  Created by 신상원 on 2022/01/03.
//

import Foundation

class BoardsViewModel {
    
    var boards = Observable(Boards())
    
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
