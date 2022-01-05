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
    var addButton = UIButton()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        boardViewModel.fetchBoards {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "새싹농장"
        setup()
        
//        boardViewModel.boards.bind { board in
//            self.tableView.reloadData()
//        }
        
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
        tableView.separatorColor = .clear
        
        view.addSubview(addButton)
        addButton.setImage(UIImage(systemName: "plus"), for: .normal)
        addButton.addTarget(self, action: #selector(addButtonClicked), for: .touchUpInside)
        addButton.clipsToBounds = true
        addButton.layer.cornerRadius = 25
        addButton.backgroundColor = .systemGreen
        addButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-30)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-18)
            make.height.width.equalTo(50)
        }
    }
    
    @objc
    func addButtonClicked() {
        let vc = AddPostViewController()
        navigationController?.pushViewController(vc, animated: true)
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
    
    // 디테일 들어가는 게 만약 댓글이 없다 -> Board 값 그대로 가져감
    // 댓글 작성중에 사용자가 게실글을 변경하는 것도 반영할 수 있도록 (코멘트 조회에서 게시글 내용을 확인할 수 있으니까 but 코멘트가 없는 경우에는 게시글 내용도 나오지 않음)
    // 디테일 들어가서 댓글 쓰는걸 누르는 순간 -> 코멘트 조회로 값을 받아올 예정
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            let vc = BoardsDetailViewController()
            vc.boardsViewModel.boardsDetail.value = self.boardViewModel.boards.value[indexPath.row]
            vc.commentViewModel.id.value = self.boardViewModel.boards.value[indexPath.row].id
            vc.title = "게시글"
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
