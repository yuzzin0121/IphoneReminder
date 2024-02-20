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
        tableView.rowHeight = 60
        tableView.register(TodoTableViewCell.self, forCellReuseIdentifier: TodoTableViewCell.identifier)
    }
}
