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
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupView() {
        self.addSubview(containerView)
        containerView.backgroundColor = .systemGray3
        [contentsView, usernameLabel, textsLabel, dateLabel, lineView, imagesView, commentLabel, countLabel].forEach {
            containerView.addSubview($0)
            $0.backgroundColor = .white
        }
    }
    
    func setupConstraints() {
        
    }
    
}
