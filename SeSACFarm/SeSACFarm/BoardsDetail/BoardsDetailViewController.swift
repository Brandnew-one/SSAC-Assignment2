//
//  BoardsDetailViewController.swift
//  SeSACFarm
//
//  Created by 신상원 on 2022/01/04.
//

import SnapKit
import UIKit

class BoardsDetailViewController: UIViewController {
    
    var boardsDetailViewModel = BoardsDetailViewModel()
    var commentViewModel = CommentViewModel()
    var deleteCommentViewModel = DeleteViewModel()
    var deletePostViewModel = DeletePostViewModel()
    
    var tableView = UITableView()
    var textButton = UIButton()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        boardsDetailViewModel.fetchSearchPost {
            self.commentViewModel.fetchCommentFind {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .plain, target: self, action: #selector(rightBarButtonClicked))
        setup()
    }
    
    @objc
    func rightBarButtonClicked() {
        print("POST Modify Button Clicked")
        DispatchQueue.main.async {
            let userID = UserDefaults.standard.integer(forKey: "userID")
            if userID != self.boardsDetailViewModel.boardsDetail.value.user.id {
                self.errorAlert {
                    print("ID가 다릅니다.")
                }
            } else {
                self.showActionSheet {
                    print("삭제버튼 클릭")
                    self.deletePostViewModel.postID.value = self.boardsDetailViewModel.boardsDetail.value.id
                    self.deletePostViewModel.fetchDeltePost {
                        self.navigationController?.popViewController(animated: true)
                    }
                    
                } editAction: {
                    print("수정버튼 클릭")
                    //댓글을 작성한 id 와 내 id 가 같은지 확인하는 과정이 필요!
                    let vc = CommitPostViewController()
                    vc.commitPostViewModel.postID.value = self.boardsDetailViewModel.boardsDetail.value.id
                    vc.commitPostViewModel.text.value = self.boardsDetailViewModel.boardsDetail.value.text
                    vc.title = "게시글 수정"
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
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
        tableView.allowsSelection = false
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
        let vc = AddCommentViewController()
        vc.title = "코멘트 작성"
        vc.addCommentViewModel.postID.value = boardsDetailViewModel.boardsDetail.value.id
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}

extension BoardsDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    //comment 조회값이 있다 -> 적어도 댓글하나 이상은 있음 -> 그럼 board 말고 comment 조회를 통해서
    //댓글값을 가져오도록 설정!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else {
            if commentViewModel.comment.value.isEmpty {
                return 0
            } else {
                return commentViewModel.comment.value.count
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if commentViewModel.comment.value.isEmpty {
            if indexPath.section == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: BoardsDetailTableViewCell.identifier, for: indexPath) as? BoardsDetailTableViewCell else {
                    return UITableViewCell()
                }
//                cell.usernameLabel.text = boardsViewModel.boardsDetail.value.user.username
//                cell.textsLabel.text = boardsViewModel.boardsDetail.value.text
//                cell.dateLabel.text = boardsViewModel.boardsDetail.value.createdAt
//                cell.countLabel.text = "\(commentViewModel.comment.value.count)"
                
                cell.usernameLabel.text = boardsDetailViewModel.boardsDetail.value.user.username
                cell.textsLabel.text = boardsDetailViewModel.boardsDetail.value.text
                cell.dateLabel.text = boardsDetailViewModel.boardsDetail.value.createdAt
                cell.countLabel.text = "\(commentViewModel.comment.value.count)"
                
                return cell
                
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: BoardsCommentTableViewCell.identifier, for: indexPath) as? BoardsCommentTableViewCell else {
                    return UITableViewCell()
                }
//                cell.usernameLabel.text = "\(boardsViewModel.boardsDetail.value.comments[indexPath.row].id)"
//                cell.commentLabel.text = boardsViewModel.boardsDetail.value.comments[indexPath.row].comment
                
                cell.usernameLabel.text = "\(boardsDetailViewModel.boardsDetail.value.comments[indexPath.row].id)"
                cell.commentLabel.text = boardsDetailViewModel.boardsDetail.value.comments[indexPath.row].comment
                
                return cell
            }
        } else {
            if indexPath.section == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: BoardsDetailTableViewCell.identifier, for: indexPath) as? BoardsDetailTableViewCell else {
                    return UITableViewCell()
                }
//                cell.usernameLabel.text = boardsViewModel.boardsDetail.value.user.username
//                cell.textsLabel.text = commentViewModel.comment.value.first?.post.text
//                cell.dateLabel.text = boardsViewModel.boardsDetail.value.createdAt
//                cell.countLabel.text = "\(commentViewModel.comment.value.count)"
                
                cell.usernameLabel.text = boardsDetailViewModel.boardsDetail.value.user.username
                cell.textsLabel.text = commentViewModel.comment.value.first?.post.text
                cell.dateLabel.text = boardsDetailViewModel.boardsDetail.value.createdAt
                cell.countLabel.text = "\(commentViewModel.comment.value.count)"
                return cell
                
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: BoardsCommentTableViewCell.identifier, for: indexPath) as? BoardsCommentTableViewCell else {
                    return UITableViewCell()
                }
                cell.modifyButton.tag = indexPath.row
                cell.modifyButton.addTarget(self, action: #selector(modifyButtonClicked(button:)), for: .touchUpInside)
                cell.usernameLabel.text = commentViewModel.comment.value[indexPath.row].user.username
                cell.commentLabel.text = commentViewModel.comment.value[indexPath.row].comment
                return cell
            }
        }
    }
    
    @objc
    func modifyButtonClicked(button: UIButton) {
        print("Modify Button Clicked")
        DispatchQueue.main.async {
            let userID = UserDefaults.standard.integer(forKey: "userID")
            if userID != self.commentViewModel.comment.value[button.tag].user.id {
                self.errorAlert {
                    print("ID가 다릅니다.")
                }
            } else {
                self.showActionSheet {
                    print("삭제버튼 클릭")
                    self.deleteCommentViewModel.commentID.value = self.commentViewModel.comment.value[button.tag].id
                    self.deleteAlert {
                        self.deleteCommentViewModel.fetchDeleteComment {
                            print("삭제완료")
                            self.commentViewModel.fetchCommentFind {
                                self.tableView.reloadData()
                            }
                        }
                    }
                } editAction: {
                    print("수정버튼 클릭")
                    //댓글을 작성한 id 와 내 id 가 같은지 확인하는 과정이 필요!
                    let vc = CommitCommentViewController()
                    vc.commitCommentViewModel.userID.value = userID
                    vc.commitCommentViewModel.commentID.value = self.commentViewModel.comment.value[button.tag].id
                    vc.commitCommentViewModel.postID.value = self.commentViewModel.comment.value[button.tag].post.id
                    vc.commitCommentViewModel.comment.value = self.commentViewModel.comment.value[button.tag].comment
                    vc.title = "코멘트 수정"
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
    
}
