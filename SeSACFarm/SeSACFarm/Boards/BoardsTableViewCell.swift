//
//  BoardsTableViewCell.swift
//  SeSACFarm
//
//  Created by 신상원 on 2022/01/03.
//

import SnapKit
import UIKit

class BoardsTableViewCell: UITableViewCell {
    
    static let identifier = "BoardsTableViewCell"
    
    var containerView = UIView()
    var contentsView = UIView() //s안쓰면 오류나는건 무야!!
    var usernameLabel = UILabel()
    var textsLabel = UILabel()
    var dateLabel = UILabel()
    var lineView = UIView()
    var imagesView = UIImageView()
    var commentLabel = UILabel()
    var countLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupView() {
        self.addSubview(containerView)
        containerView.backgroundColor = .systemGray4
        containerView.addSubview(contentsView)
        contentsView.backgroundColor = .white
        [usernameLabel, textsLabel, dateLabel, lineView, imagesView, commentLabel, countLabel].forEach {
            contentsView.addSubview($0)
            $0.backgroundColor = .white
        }
        usernameLabel.backgroundColor = .systemGray4
        usernameLabel.font = .systemFont(ofSize: 12)
        usernameLabel.textColor = .systemGray
        
        textsLabel.font = .boldSystemFont(ofSize: 13)
        textsLabel.numberOfLines = 0
        dateLabel.font = .systemFont(ofSize: 12)
        commentLabel.font = .systemFont(ofSize: 13)
        countLabel.font = .systemFont(ofSize: 13)
        imagesView.image = UIImage(systemName: "message")
        
        lineView.backgroundColor = .systemGray4
    }
    
    func setupConstraints() {
        
        containerView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        contentsView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(4)
            make.bottom.equalToSuperview().offset(-4)
        }
        
        usernameLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(18)
            //trailing 추가해야 될 수도 있음
        }
        
        textsLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().offset(-18)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(textsLabel.snp.bottom).offset(18)
            make.leading.equalToSuperview().offset(18)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(18)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        imagesView.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(18)
            make.width.height.equalTo(20)
            make.bottom.equalToSuperview().offset(-8)
        }
        
        commentLabel.snp.makeConstraints { make in
            make.centerY.equalTo(imagesView)
            make.leading.equalTo(imagesView.snp.trailing).offset(8)
        }
        
        countLabel.snp.makeConstraints { make in
            make.centerY.equalTo(imagesView)
            make.leading.equalTo(commentLabel.snp.trailing).offset(8)
        }
        
    }
    
}
