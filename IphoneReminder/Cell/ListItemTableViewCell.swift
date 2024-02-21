//
//  ListItemTableViewCell.swift
//  IphoneReminder
//
//  Created by 조유진 on 2/21/24.
//

import UIKit
import SnapKit

class ListItemTableViewCell: UITableViewCell {
    let listImageBackgroundView = UIView()
    let listImageView = UIImageView()
    let listTitelLabel = UILabel()
    let detailLabel = UILabel()
    let arrowImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        configureCell(listItem: nil)
    }
    
    func configureCell(listItem: ListItem?) {
        guard let listItem = listItem else { return }
        listImageBackgroundView.backgroundColor = UIColor(named: listItem.colorName)
        listImageView.backgroundColor = UIColor(named: listItem.colorName)
        listTitelLabel.text = listItem.title
        detailLabel.text = "\(listItem.todos.count)"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHierarchy() {
        [listImageBackgroundView, listTitelLabel, detailLabel, arrowImageView].forEach {
            contentView.addSubview($0)
        }
        
        listImageBackgroundView.addSubview(listImageView)
    }
    private func configureLayout() {
        listImageBackgroundView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(14)
            make.size.equalTo(30)
        }
        listImageView.snp.makeConstraints { make in
            make.center.equalTo(listImageBackgroundView)
            make.size.equalTo(20)
        }
        listTitelLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(listImageBackgroundView.snp.trailing).offset(12)
            make.trailing.equalTo(detailLabel.snp.leading).offset(-8)
            make.height.equalTo(16)
        }
        arrowImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(14)
            make.size.equalTo(16)
        }
        detailLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(detailLabel.snp.trailing).offset(-12)
            make.height.equalTo(16)
        }
    }
    private func configureView() {
        contentView.backgroundColor = ColorStyle.deepDarkGray
        
        listTitelLabel.textColor = .white
        listTitelLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        
        listImageView.image = ImageStyle.list
        listImageView.backgroundColor = .clear
        listImageView.tintColor = .white
        listImageView.backgroundColor = .darkGray
        listImageView.contentMode = .scaleAspectFit
        
        detailLabel.textColor = .systemGray5
        detailLabel.font = .systemFont(ofSize: 14)
        
        arrowImageView.image = ImageStyle.arrowRight
        arrowImageView.contentMode = .scaleAspectFit
        arrowImageView.tintColor = .systemGray2
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        DispatchQueue.main.async {
            self.listImageBackgroundView.layer.cornerRadius = self.listImageBackgroundView.frame.height / 2
            self.listImageBackgroundView.clipsToBounds = true
        }
    }
}
