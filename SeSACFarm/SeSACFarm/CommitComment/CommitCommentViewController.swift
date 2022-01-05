//
//  CommitCommentViewController.swift
//  SeSACFarm
//
//  Created by 신상원 on 2022/01/05.
//

import SnapKit
import UIKit

class CommitCommentViewController: UIViewController {
    
    var commitCommentViewModel = CommitCommentViewModel()
    var commentView = CommentView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(leftBarButtonClicked))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(rightBarButtonClicked))
        setup()
        
//        print("VC UserID: ",commitCommentViewModel.userID.value)
//        print("VC PostID: ",commitCommentViewModel.postID.value)
//        print("VC CommentID: ",commitCommentViewModel.commentID.value)
//        print("VC Comment: ",commitCommentViewModel.comment.value)
        
    }
    
    @objc
    func leftBarButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    func rightBarButtonClicked() {
        commitCommentViewModel.comment.value = commentView.textView.text
        commitCommentViewModel.fetchCommitComment {
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func setup() {
        view.addSubview(commentView)
        commentView.textView.text = commitCommentViewModel.comment.value
        commentView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
