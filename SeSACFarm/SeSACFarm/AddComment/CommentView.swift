//
//  CommentView.swift
//  SeSACFarm
//
//  Created by 신상원 on 2022/01/05.
//

import SnapKit
import UIKit

//추가, 수정 공유할 예정
class CommentView: UIView {
    
    var textView = UITextView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupView() {
        self.addSubview(textView)
        textView.font = .boldSystemFont(ofSize: 13)
        textView.layer.borderColor = CGColor.init(red: 0, green: 0, blue: 0, alpha: 1)
        textView.layer.borderWidth = 1
    }
    
    func setupConstraints() {
        textView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.height.equalTo(200)
        }
    }
    
}
