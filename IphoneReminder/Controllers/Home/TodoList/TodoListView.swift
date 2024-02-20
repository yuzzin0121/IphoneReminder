//
//  TotalView.swift
//  IphoneReminder
//
//  Created by 조유진 on 2/15/24.
//

import UIKit

class TodoListView: BaseView {
    let tableView = UITableView()
    
    override func configureHierarchy() {
        addSubview(tableView)
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide).inset(14)
        }
    }
    
    override func configureView() {
        tableView.backgroundColor = .black
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0)
        tableView.rowHeight = 80
        tableView.register(TodoTableViewCell.self, forCellReuseIdentifier: TodoTableViewCell.identifier)
    }
}
