//
//  CommitPostViewController.swift
//  SeSACFarm
//
//  Created by 신상원 on 2022/01/05.
//

import SnapKit
import UIKit

//Post 작성하고 view 동일하게 사용하기
class CommitPostViewController: UIViewController {
    
    var commitPostViewModel = CommitPostModel()
    var postView = PostView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(leftBarButtonClicked))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(rightBarButtonClicked))
        view.backgroundColor = .white
        setup()
    }
    
    @objc
    func leftBarButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    func rightBarButtonClicked() {
        commitPostViewModel.text.value = postView.textView.text
        commitPostViewModel.fetchCommitPost {
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func setup() {
        view.addSubview(postView)
        postView.textView.text = commitPostViewModel.text.value
        postView.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide).offset(18)
            make.trailing.bottom.equalTo(view.safeAreaLayoutGuide).offset(-18)
        }
    }
    
}
