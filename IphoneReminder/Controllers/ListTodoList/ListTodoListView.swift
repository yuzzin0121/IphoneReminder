//
//  ListTodoListView.swift
//  IphoneReminder
//
//  Created by 조유진 on 2/22/24.
//

import UIKit

class ListTodoListView: BaseView {
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
