//
//  MemoTableViewCell.swift
//  IphoneReminder
//
//  Created by 조유진 on 2/15/24.
//

import UIKit

class MemoTableViewCell: UITableViewCell {
    let titleTextField = TableTextField()
    let memoTextField = TableTextField()
    
    var titlePlaceholder = "제목"
    var memoPlaceholder = "메모"

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
    
    func configureCell(title: String?, memo: String?) {
        if let title = title {
            titleTextField.text = title
        }
        if let memo = memo {
            memoTextField.text = memo
        }
    }
    
    func configureHierarchy() {
        [titleTextField, memoTextField].forEach {
            contentView.addSubview($0)
        }
    }
    
    func configureLayout() {
        titleTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(14)
            make.top.equalToSuperview().offset(6)
            make.height.equalTo(44)
        }
        
        memoTextField.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(14)
            make.height.equalTo(44)
        }
    }
    
    func configureView() {
        contentView.backgroundColor = ColorStyle.deepDarkGray
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true
        
        titleTextField.placeholder = titlePlaceholder
        memoTextField.placeholder = memoPlaceholder
        titleTextField.attributedPlaceholder = NSAttributedString(string: titlePlaceholder,
                                                     attributes: [
                                                        .foregroundColor: UIColor.lightGray
                                                     ])
        memoTextField.attributedPlaceholder = NSAttributedString(string: memoPlaceholder,
                                                     attributes: [
                                                        .foregroundColor: UIColor.lightGray
                                                     ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
