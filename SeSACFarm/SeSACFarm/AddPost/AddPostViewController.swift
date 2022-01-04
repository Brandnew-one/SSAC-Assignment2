//
//  AddPostViewController.swift
//  SeSACFarm
//
//  Created by 신상원 on 2022/01/04.
//

import SnapKit
import UIKit


class AddPostViewController: UIViewController {
    
    var postViewModel = AddPostViewModel()
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
        //bind를 해줘야 하는건가?
        postViewModel.postText.value = postView.textView.text
        postViewModel.fetchAddPost {
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func setup() {
        view.addSubview(postView)
        
        postView.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide).offset(18)
            make.trailing.bottom.equalTo(view.safeAreaLayoutGuide).offset(-18)
        }
    }
    
}
