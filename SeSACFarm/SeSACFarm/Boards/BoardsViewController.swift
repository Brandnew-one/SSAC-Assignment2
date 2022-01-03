//
//  BoardsViewController.swift
//  SeSACFarm
//
//  Created by 신상원 on 2022/01/03.
//

import SnapKit
import UIKit

class BoardsViewController: UIViewController {
    
    var boardViewModel = BoardsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        boardViewModel.fetchBoards()
    }
    
}
