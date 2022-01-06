//
//  BoardsViewModel.swift
//  SeSACFarm
//
//  Created by 신상원 on 2022/01/03.
//

import UIKit

class BoardsViewModel {
    
    var boards = Observable(Boards())
    
    func fetchBoards(completion: @escaping () -> Void) {
        APIService.boards() { userData, error in
            guard let userData = userData else {
                //만약 토큰이 만료되었다면 초기화면으로 갈 수 있도록 (얼럿 띄워주기)
                //사용자에게 토큰이 만료되었음을 알려주는게 필요
                if error == .errorToken {
                    print("토큰 만료")
                    DispatchQueue.main.async {
                        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                        windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: MainViewController())
                        windowScene.windows.first?.makeKeyAndVisible()
                    }
                }
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
