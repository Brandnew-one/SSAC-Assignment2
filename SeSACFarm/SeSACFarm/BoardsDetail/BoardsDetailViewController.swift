//
//  BoardsDetailViewController.swift
//  SeSACFarm
//
//  Created by 신상원 on 2022/01/04.
//

import SnapKit
import UIKit

class BoardsDetailViewController: UIViewController {
    
    var boardsViewModel = BoardsViewModel()
    var tableView = UITableView()
    var textButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
    }
    
    func setup() {
        view.addSubview(textButton)
        textButton.setTitle("  댓글을 입력해주세요", for: .normal)
        textButton.backgroundColor = .systemGray2
        textButton.clipsToBounds = true
        textButton.layer.cornerRadius = 10
        textButton.addTarget(self, action: #selector(textButtonClicked), for: .touchUpInside)
        
        textButton.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.trailing.bottom.equalTo(view.safeAreaLayoutGuide).offset(-8)
            make.height.equalTo(35)
        }
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(BoardsDetailTableViewCell.self, forCellReuseIdentifier: BoardsDetailTableViewCell.identifier)
        tableView.register(BoardsCommentTableViewCell.self, forCellReuseIdentifier: BoardsCommentTableViewCell.identifier)
        
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(textButton.snp.top)
        }
    }
    
    @objc
    func textButtonClicked() {
        
    }
    
}

extension BoardsDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else {
            return boardsViewModel.boardsDetail.value.comments.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BoardsDetailTableViewCell.identifier, for: indexPath) as? BoardsDetailTableViewCell else {
                return UITableViewCell()
            }
            cell.usernameLabel.text = boardsViewModel.boardsDetail.value.user.username
            cell.textsLabel.text = boardsViewModel.boardsDetail.value.text
            cell.dateLabel.text = boardsViewModel.boardsDetail.value.createdAt
            cell.countLabel.text = "\(boardsViewModel.boardsDetail.value.comments.count)"
            return cell
            
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BoardsCommentTableViewCell.identifier, for: indexPath) as? BoardsCommentTableViewCell else {
                return UITableViewCell()
            }
            cell.usernameLabel.text = "\(boardsViewModel.boardsDetail.value.comments[indexPath.row].id)"
            cell.commentLabel.text = boardsViewModel.boardsDetail.value.comments[indexPath.row].comment
            return cell
        }
    }
    
    
}
