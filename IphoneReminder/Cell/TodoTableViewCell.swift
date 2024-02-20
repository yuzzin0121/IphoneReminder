//
//  TodoTableViewCell.swift
//  IphoneReminder
//
//  Created by 조유진 on 2/15/24.
//

import UIKit

class TodoTableViewCell: UITableViewCell {
    let isCompletedIcon = UIButton()
    let titleLabel = UILabel()
    let memoLabel = UILabel()
    let deadLineDateLabel = UILabel()
    let tagLabel = UILabel()
    let selectedimageView = UIImageView()

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
        let priorityString = getPriorityString(priority: todo.priority)
        titleLabel.text = "\(priorityString) \(todo.title)"
        titleLabel.asColor(targetString: priorityString, color: .systemBlue)
        if let memo = todo.memo {
            memoLabel.text = memo
        }
        deadLineDateLabel.text = changeFormat(date: todo.deadLineDate)
        tagLabel.text = "#\(todo.tag)"
        
        let image = todo.isCompleted ? ImageStyle.checkCircle : ImageStyle.circle
        isCompletedIcon.setImage(image, for: .normal)
    }
    
    func getPriorityString(priority: String) -> String {
        switch priority {
        case "하": return "!"
        case "중": return "!!"
        case "상": return "!!!"
        default:
            return ""
        }
    }
    
    private func changeFormat(date: Date) -> String? {
        // 선택된 날짜를 문자열로 변환하여 출력
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd" // 원하는 날짜 형식 지정
        return dateFormatter.string(from: date)
    }
    
    func configureHierarchy() {
        [isCompletedIcon, titleLabel, memoLabel, deadLineDateLabel, tagLabel, selectedimageView].forEach {
            contentView.addSubview($0)
        }
    }
    func configureLayout() {
        isCompletedIcon.snp.makeConstraints { make in
            make.size.equalTo(18)
            make.leading.top.equalToSuperview().offset(12)
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(isCompletedIcon.snp.trailing).offset(12)
            make.top.equalToSuperview().inset(12)
            make.height.equalTo(17)
        }
        memoLabel.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.leading.equalTo(titleLabel.snp.trailing).offset(8)
            make.height.equalTo(15)
        }
        deadLineDateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(6)
            make.leading.equalTo(titleLabel)
            make.bottom.equalToSuperview().inset(12)
            make.height.equalTo(12)
        }
        tagLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(6)
            make.leading.equalTo(deadLineDateLabel.snp.trailing).offset(12)
            make.height.equalTo(13)
        }
        selectedimageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(12)
            make.trailing.equalToSuperview().inset(12)
            make.size.equalTo(70)
        }
    }
    func configureView() {
        contentView.backgroundColor = .black
        isCompletedIcon.setImage(ImageStyle.circle, for: .normal)
        isCompletedIcon.tintColor = .white
        tagLabel.design(font: .systemFont(ofSize: 13), textColor: .systemBlue)
        titleLabel.design(font: .boldSystemFont(ofSize: 16))
        memoLabel.design(font: .boldSystemFont(ofSize: 14), textColor: .lightGray)
        deadLineDateLabel.design(font: .systemFont(ofSize: 12), textColor: .gray)
//        priorityLabel.design(font: .systemFont(ofSize: 13), textColor: .lightGray)
        selectedimageView.contentMode = .scaleAspectFill
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
