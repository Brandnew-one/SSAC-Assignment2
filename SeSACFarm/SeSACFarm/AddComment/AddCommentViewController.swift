//
//  AddCommentViewController.swift
//  SeSACFarm
//
//  Created by 신상원 on 2022/01/05.
//

import SnapKit
import UIKit

class AddCommentViewController: UIViewController {
    
    var addCommentViewModel = AddCommentViewModel()
    var commentView = CommentView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(leftBarButtonClicked))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(rightBarButtonClicked))
        
        setup()
    }
    
    @objc
    func leftBarButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    func rightBarButtonClicked() {
        addCommentViewModel.textComment.value = commentView.textView.text
        addCommentViewModel.fetchAddComment(comment: addCommentViewModel.textComment.value, post: addCommentViewModel.postID.value) {
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func setup() {
        view.addSubview(commentView)
        commentView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    
}
