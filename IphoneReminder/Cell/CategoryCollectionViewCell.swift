//
//  CategoryCollectionViewCell.swift
//  IphoneReminder
//
//  Created by 조유진 on 2/15/24.
//

import UIKit
import SnapKit

class CategoryCollectionViewCell: UICollectionViewCell {
    let imageBackgroundView = UIView()
    let iconImageView = UIImageView()
    let titleLabel = UILabel()
    let countLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    func configureCell(iconImage: UIImage, backgroundColor: UIColor, title: String, count: Int) {
        iconImageView.image = iconImage
        imageBackgroundView.backgroundColor = backgroundColor
        titleLabel.text = title
        countLabel.text = "\(count)"
    }
    
    func configureHierarchy() {
        [imageBackgroundView, titleLabel, countLabel].forEach {
            contentView.addSubview($0)
        }
        imageBackgroundView.addSubview(iconImageView)
    }
    func configureLayout() {
        imageBackgroundView.snp.makeConstraints { make in
            make.size.equalTo(36)
            make.leading.top.equalToSuperview().offset(8)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.center.equalTo(imageBackgroundView)
            make.size.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(15)
            make.leading.equalTo(imageBackgroundView)
            make.top.equalTo(imageBackgroundView.snp.bottom).offset(8)
            make.bottom.equalToSuperview().inset(8)
        }
        
        countLabel.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.top.trailing.equalToSuperview().inset(12)
        }
    }
    func configureView() {
        contentView.backgroundColor = ColorStyle.deepDarkGray
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = .white
        titleLabel.font = .systemFont(ofSize: 15)
        titleLabel.textColor = .lightGray
        countLabel.textColor = .white
        countLabel.font = .boldSystemFont(ofSize: 24)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        DispatchQueue.main.async {
            self.imageBackgroundView.layer.cornerRadius = self.imageBackgroundView.frame.height / 2
            self.imageBackgroundView.clipsToBounds = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
