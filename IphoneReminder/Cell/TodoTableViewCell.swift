//
//  TodoTableViewCell.swift
//  IphoneReminder
//
//  Created by 조유진 on 2/15/24.
//

import UIKit

class TodoTableViewCell: UITableViewCell {
    let titleLabel = UILabel()
    let memoLabel = UILabel()
    let deadLineDateLabel = UILabel()
    let tagLabel = UILabel()
    let priorityLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configureCell(todo: TodoModel?) {
        guard let todo = todo else { return }
        titleLabel.text = todo.title
        if let memo = todo.memo {
            memoLabel.text = memo
        }
        deadLineDateLabel.text = changeFormat(date: todo.deadLineDate)
        tagLabel.text = todo.tag
        priorityLabel.text = todo.priority
    }
    
    private func changeFormat(date: Date) -> String? {
        // 선택된 날짜를 문자열로 변환하여 출력
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd" // 원하는 날짜 형식 지정
        return dateFormatter.string(from: date)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0))
    }
    
    func configureHierarchy() {
        [titleLabel, memoLabel, deadLineDateLabel, tagLabel, priorityLabel].forEach {
            contentView.addSubview($0)
        }
    }
    func configureLayout() {
        tagLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().inset(8)
            make.height.equalTo(13)
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(tagLabel)
            make.top.equalTo(tagLabel.snp.bottom).offset(8)
            make.height.equalTo(15)
        }
        memoLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel)
            make.leading.equalTo(titleLabel.snp.trailing).offset(8)
            make.height.equalTo(15)
        }
        deadLineDateLabel.snp.makeConstraints { make in
            make.bottom.trailing.equalToSuperview().inset(8)
            make.height.equalTo(12)
        }
        priorityLabel.snp.makeConstraints { make in
            make.trailing.top.equalToSuperview().inset(8)
            make.height.equalTo(13)
        }
    }
    func configureView() {
        contentView.backgroundColor = ColorStyle.deepDarkGray
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
        tagLabel.design(font: .systemFont(ofSize: 13), textColor: .systemGray6)
        titleLabel.design(font: .boldSystemFont(ofSize: 15))
        memoLabel.design(font: .boldSystemFont(ofSize: 15))
        deadLineDateLabel.design(font: .systemFont(ofSize: 12), textColor: .systemGray6)
        priorityLabel.design(font: .systemFont(ofSize: 13), textColor: .lightGray)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
