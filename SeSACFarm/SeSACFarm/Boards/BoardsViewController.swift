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
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
        
        boardViewModel.fetchBoards()
        boardViewModel.boards.bind { board in
            self.tableView.reloadData()
        }
    }
    
    func setup() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(BoardsTableViewCell.self, forCellReuseIdentifier: BoardsTableViewCell.identifier)
    }
    
    
}

extension BoardsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return boardViewModel.numberOfRowInSection
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BoardsTableViewCell.identifier, for: indexPath) as? BoardsTableViewCell else {
            return UITableViewCell()
        }
        let row = boardViewModel.cellForRowAt(at: indexPath)
        DispatchQueue.main.async {
            cell.usernameLabel.text = row.user.username
            cell.textsLabel.text = row.text
            cell.dateLabel.text = row.createdAt
            cell.commentLabel.text = "댓글"
            cell.countLabel.text = "\(row.comments.count)"
        }
        return cell
    }
    

    
}
