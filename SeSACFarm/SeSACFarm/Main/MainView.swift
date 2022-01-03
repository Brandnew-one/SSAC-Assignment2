//
//  MainView.swift
//  SeSACFarm
//
//  Created by 신상원 on 2022/01/03.
//

import SnapKit
import UIKit

class MainView: UIView {
    
    var imageView = UIImageView()
    var titleLable = UILabel()
    var contentLabel = UILabel()
    var startButton = UIButton()
    var descriptionLabel = UILabel()
    var loginButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupView() {
        [imageView, titleLable, contentLabel, startButton, descriptionLabel, loginButton].forEach {
            self.addSubview($0)
            $0.backgroundColor = .white
        }
        
        imageView.image = UIImage(named: "logo_ssac_white")
        
        titleLable.font = .boldSystemFont(ofSize: 18)
        titleLable.text = "당신 근처의 새싹농장"
        titleLable.textAlignment = .center
        
        contentLabel.font = .systemFont(ofSize: 13)
        contentLabel.numberOfLines = 2
        contentLabel.text = "나태지옥에 빠져버린 벌레같은 나\n신년에는 새로운 삶을 살아갈 수 있을것인가?"
        contentLabel.textAlignment = .center
        
        descriptionLabel.text = "이미 계정이 있나요?"
        descriptionLabel.font = .systemFont(ofSize: 12)
        descriptionLabel.textColor = .systemGray
        descriptionLabel.textAlignment = .center
        
        loginButton.setTitle("로그인", for: .normal)
        loginButton.titleLabel?.font = .systemFont(ofSize: 12)
        loginButton.setTitleColor(.systemGreen, for: .normal)
        
        startButton.backgroundColor = .systemGreen
        startButton.setTitle("시작하기", for: .normal)
        startButton.setTitleColor(.white, for: .normal)
        startButton.clipsToBounds = true
        startButton.layer.cornerRadius = 10
    }
    
    func setupConstraints() {
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-80)
            make.width.height.equalTo(180)
        }
        
        titleLable.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(18)
            make.centerX.equalToSuperview()
            make.width.equalTo(imageView.snp.width).multipliedBy(1.2)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLable.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.width.equalTo(imageView.snp.width).multipliedBy(1.5)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
//            make.width.equalTo(imageView.snp.width).multipliedBy(0.8)
        }
        
        loginButton.snp.makeConstraints { make in
            make.centerY.equalTo(descriptionLabel)
            make.leading.equalTo(descriptionLabel.snp.trailing).offset(8)
//            make.trailing.equalToSuperview().offset(-8)
        }
        
        startButton.snp.makeConstraints { make in
            make.bottom.equalTo(descriptionLabel.snp.top).offset(-20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(40)
        }
    }
    
}
