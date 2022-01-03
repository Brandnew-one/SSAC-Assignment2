//
//  BoardsViewModel.swift
//  SeSACFarm
//
//  Created by 신상원 on 2022/01/03.
//

import Foundation

class BoardsViewModel {
    
    var boards = Observable(Boards())
    
    func fetchBoards() {
        APIService.boards() { userData, error in
            guard let userData = userData else {
                return
            }
//            print(userData)
            self.boards.value = userData
            print(userData.count)
        }
    }
}
