//
//  AddView.swift
//  IphoneReminder
//
//  Created by 조유진 on 2/15/24.
//

import UIKit
import SnapKit

class AddView: BaseView {
    
    let tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureHierarchy() {
        addSubview(tableView)
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide).inset(12)
        }
    }
    
    override func configureView() {
        backgroundColor = ColorStyle.darkBlack
        tableView.backgroundColor = ColorStyle.darkBlack
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.separatorInset = .init(top: 0, left: 0, bottom: 12, right: 0)
        tableView.register(MemoTableViewCell.self, forCellReuseIdentifier: MemoTableViewCell.identifier)
        tableView.register(InfoTableViewCell.self, forCellReuseIdentifier: InfoTableViewCell.identifier)
    }
}
