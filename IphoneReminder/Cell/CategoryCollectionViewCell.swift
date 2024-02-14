//
//  CategoryCollectionViewCell.swift
//  IphoneReminder
//
//  Created by 조유진 on 2/15/24.
//

import UIKit
import SnapKit

class CategoryCollectionViewCell: UICollectionViewCell {
    let iconImageView = UIImageView()
    let titleLabel = UILabel()
    let countLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    func configureCell(iconImage: UIImage, tintColor: UIColor, title: String, count: Int) {
        iconImageView.image = iconImage
        iconImageView.tintColor = tintColor
        titleLabel.text = title
        countLabel.text = "\(count)"
    }
    
    func configureHierarchy() {
        [iconImageView, titleLabel, countLabel].forEach {
            contentView.addSubview($0)
        }
    }
    func configureLayout() {
        iconImageView.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.leading.top.equalToSuperview().offset(8)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(15)
            make.leading.equalTo(iconImageView)
            make.top.equalTo(iconImageView.snp.bottom).offset(8)
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
        titleLabel.font = .systemFont(ofSize: 15)
        titleLabel.textColor = .lightGray
        countLabel.textColor = .white
        countLabel.font = .boldSystemFont(ofSize: 22)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
