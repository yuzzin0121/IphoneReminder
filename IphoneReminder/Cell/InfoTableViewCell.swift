//
//  InfoTableViewCell.swift
//  IphoneReminder
//
//  Created by 조유진 on 2/15/24.
//

import UIKit

final class InfoTableViewCell: UITableViewCell {
    let titleLabel = UILabel()
    let valueLabel = UILabel()
    let seletecimageView = UIImageView()
    let rightAllowImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0))
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        seletecimageView.image = nil
    }
    
    func configureCell(title: String, value: String?) {
        titleLabel.text = title
        if let value = value {
            valueLabel.text = value
        }
    }
    
    func configureHierarchy() {
        [titleLabel, valueLabel, rightAllowImageView, seletecimageView].forEach {
            contentView.addSubview($0)
        }
    }
    
    func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(14)
            make.height.equalTo(20)
        }
        
        valueLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(titleLabel.snp.trailing).offset(12)
            make.height.equalTo(20)
            make.trailing.equalTo(rightAllowImageView.snp.leading).offset(-12)
        }
        
        seletecimageView.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.centerY.equalToSuperview()
            make.trailing.equalTo(rightAllowImageView.snp.leading).offset(-12)
        }
        
        rightAllowImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(14)
            make.size.equalTo(14)
        }
    }
    
    func configureView() {
        contentView.backgroundColor = ColorStyle.deepDarkGray
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 14)
        valueLabel.textColor = .white
        valueLabel.font = .systemFont(ofSize: 14)
        rightAllowImageView.image = ImageStyle.arrowRight
        rightAllowImageView.contentMode = .scaleAspectFit
        rightAllowImageView.tintColor = .white
        
        seletecimageView.contentMode = .scaleAspectFill
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
