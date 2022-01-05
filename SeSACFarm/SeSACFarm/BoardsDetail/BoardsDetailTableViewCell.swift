//
//  BoardsDetailTableViewCell.swift
//  SeSACFarm
//
//  Created by 신상원 on 2022/01/04.
//

import SnapKit
import UIKit

class BoardsDetailTableViewCell: UITableViewCell {
    
    static let identifier = "BoardsDetailTableViewCell"
    
    var userImageView = UIImageView()
    var usernameLabel = UILabel()
    var dateLabel = UILabel()
    var lineView1 = UIView()
    var textsLabel = UILabel()
    var lineView2 = UIView()
    
    var commentImageView = UIImageView()
    var commentLabel = UILabel()
    var countLabel = UILabel()
    var lineView3 = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupView() {
        [userImageView, usernameLabel, dateLabel, lineView1, textsLabel, commentImageView, lineView2, commentLabel, countLabel, lineView3].forEach {
            self.addSubview($0)
            $0.backgroundColor = .white
        }
        usernameLabel.font = .systemFont(ofSize: 13)
        dateLabel.font = .systemFont(ofSize: 12)
        lineView1.backgroundColor = .systemGray4
        lineView2.backgroundColor = .systemGray4
        lineView3.backgroundColor = .systemGray4
        userImageView.image = UIImage(systemName: "person")
        
        textsLabel.font = .boldSystemFont(ofSize: 13)
        textsLabel.numberOfLines = 0
        
        commentLabel.font = .systemFont(ofSize: 13)
        commentLabel.text = "댓글"
        countLabel.font = .systemFont(ofSize: 13)
        commentImageView.image = UIImage(systemName: "message")
    }
    
    func setupConstraints() {
        
        userImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(18)
            make.height.width.equalTo(36)
        }
        
        usernameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.leading.equalTo(userImageView.snp.trailing).offset(8)
            make.trailing.equalToSuperview().offset(-8)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel.snp.bottom).offset(8)
            make.leading.equalTo(userImageView.snp.trailing).offset(8)
            make.trailing.equalToSuperview().offset(-8)
        }
        
        lineView1.snp.makeConstraints { make in
            make.top.equalTo(userImageView.snp.bottom).offset(18)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        textsLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView1.snp.bottom).offset(18)
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().offset(-18)
        }
        
        lineView2.snp.makeConstraints { make in
            make.top.equalTo(textsLabel.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        commentImageView.snp.makeConstraints { make in
            make.top.equalTo(lineView2.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(18)
            make.width.height.equalTo(20)
            make.bottom.equalToSuperview().offset(-8)
        }
        
        commentLabel.snp.makeConstraints { make in
            make.centerY.equalTo(commentImageView)
            make.leading.equalTo(commentImageView.snp.trailing).offset(8)
            make.bottom.equalToSuperview().offset(-8)
        }
        
        countLabel.snp.makeConstraints { make in
            make.centerY.equalTo(commentImageView)
            make.leading.equalTo(commentLabel.snp.trailing).offset(8)
            make.bottom.equalToSuperview().offset(-8)
        }
    }
}

class BoardsCommentTableViewCell: UITableViewCell {
    
    static let identifier = "BoardsCommentTableViewCell"
    
    var usernameLabel = UILabel()
    var commentLabel = UILabel()
    var modifyButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupView() {
        [usernameLabel, commentLabel, modifyButton].forEach {
            contentView.addSubview($0)
            $0.backgroundColor = .white
        }
        usernameLabel.font = .boldSystemFont(ofSize: 12)
        commentLabel.numberOfLines = 0
        commentLabel.font = .systemFont(ofSize: 12)
        modifyButton.setImage(UIImage(systemName: "ellipsis.vertical.bubble"), for: .normal)
    }
    
    func setupConstraints() {
        
        modifyButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().offset(-18)
            make.height.width.equalTo(30)
        }
        
        usernameLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(18)
            make.trailing.equalTo(modifyButton.snp.leading).offset(-18)
        }
        
        commentLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalTo(modifyButton.snp.leading).offset(-18)
            make.bottom.equalToSuperview().offset(-8)
        }
        
    }
}
