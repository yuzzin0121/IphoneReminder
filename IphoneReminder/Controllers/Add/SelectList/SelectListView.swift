//
//  SelectListView.swift
//  IphoneReminder
//
//  Created by 조유진 on 2/22/24.
//

import UIKit
import SnapKit

class SelectListView: BaseView {
    let messageLabel = UILabel()
    let tableView = UITableView()
    
    override func configureHierarchy() {
        addSubview(messageLabel)
        addSubview(tableView)
    }
    override func configureLayout() {
        messageLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.top.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(20)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(messageLabel.snp.bottom).offset(12)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    override func configureView() {
        backgroundColor = ColorStyle.darkBlack
        
        messageLabel.text = "미리알림이 '미리알림'에 생성됩니다."
        messageLabel.design(font: .boldSystemFont(ofSize: 16), textColor: .white)
        messageLabel.textAlignment = .center
        
        tableView.backgroundColor = ColorStyle.darkBlack
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        tableView.showsVerticalScrollIndicator = false
        tableView.register(SelectListTableViewCell.self, forCellReuseIdentifier: SelectListTableViewCell.identifier)
    }
}
