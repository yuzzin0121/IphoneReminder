//
//  TotalViewController.swift
//  IphoneReminder
//
//  Created by 조유진 on 2/15/24.
//

import UIKit
import RealmSwift

enum Filter: Int, CaseIterable {
    case total
    case deadLine
    case title
    case lowPriority
    case highPriority
    
    var title: String {
        switch self {
        case .total: return "전체 보기"
        case .deadLine: return "마감일 순으로 보기"
        case .title: return "제목 순으로 보기"
        case .lowPriority: return "우선순위 낮음 만 보기"
        case .highPriority: return "우선순위 높음 만 보기"
        }
    }
    
    var sortKey: String {
        switch self {
        case .total: return "createdAt"
        case .deadLine: return "deadLineDate"
        case .title: return "title"
        case .lowPriority: return "하"
        case .highPriority: return "상"
        }
    }
}

class TotalViewController: BaseViewController {
    let mainView = TotalView()
    let filterButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageStyle.threeDot, for: .normal)
        return button
    }()
    let filterList = Filter.allCases
    var todoList: Results<TodoModel>!
    lazy var selectedDeadLine = { (action: UIAction) in
        self.getDeadLine()
    }
    lazy var selectedTotal = { (action: UIAction) in
        self.getTotalTodo()
    }
    lazy var selectedTitle = { (action: UIAction) in
        self.getTitle()
    }
    lazy var selectedLowPriority = { (action: UIAction) in
        self.getLowPrioirty()
    }
    lazy var selectedHighPriority = { (action: UIAction) in
        self.getHighPrioirty()
    }
    
    var todoTableRepository = TodoTableRepository()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureFilterButton()
        configureTableView()
        configureNavigationItem()
        getTotalTodo()
    }
    
    func configureFilterButton() {
        filterButton.menu = UIMenu(children: [
            UIAction(title: Filter.total.title, state: .on, handler: selectedTotal),
            UIAction(title: Filter.deadLine.title, handler: selectedDeadLine),
            UIAction(title: Filter.title.title, handler: selectedTotal),
            UIAction(title: Filter.lowPriority.title, handler: selectedTotal),
            UIAction(title: Filter.highPriority.title, handler: selectedHighPriority)])
        filterButton.showsMenuAsPrimaryAction = true
        filterButton.changesSelectionAsPrimaryAction = true
    }
    
    private func getDeadLine() {
        todoList = todoTableRepository.sortData(key: Filter.deadLine.sortKey)
        mainView.tableView.reloadData()
    }
    
    private func getTitle() {
        todoList = todoTableRepository.sortData(key: Filter.title.sortKey)
        mainView.tableView.reloadData()
    }
    
    private func getLowPrioirty() {
        todoList = todoTableRepository.fetchPriorityFilter(Filter.lowPriority.sortKey)
        mainView.tableView.reloadData()
    }
    
    private func getHighPrioirty() {
        todoList = todoTableRepository.fetchPriorityFilter(Filter.highPriority.sortKey)
        mainView.tableView.reloadData()
    }
    
    private func getTotalTodo() {
        todoList = todoTableRepository.sortData(key: Filter.total.sortKey)
        mainView.tableView.reloadData()
    }
    
    private func configureTableView() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
    }
    
    private func configureNavigationItem() {
        navigationItem.title = "전체"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        let filterbutton = filterButton
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: filterbutton)
    }
    
    override func loadView() {
        view = mainView
    }
    
    func updateIsComplete(item: TodoModel) {
        todoTableRepository.updateisCompleted(item)
        getTotalTodo()
    }

    func deleteTodo(item: TodoModel) {
        todoTableRepository.deleteItem(item)
        getTotalTodo()
    }
}

extension TotalViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TodoTableViewCell.identifier, for: indexPath) as? TodoTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.backgroundColor = .black
        cell.configureCell(todo: todoList[indexPath.row])
        // 도큐먼트 폴더에 있는 이미지를 셀에 보여주기
        if let image = loadImageToDocument(filename: "\(todoList[indexPath.row].id)") {
            cell.selectedimageView.image = image
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = todoList[indexPath.row]
        updateIsComplete(item: item)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "삭제하기") {
            (_,_, completionHandler) in
            let item = self.todoList[indexPath.row]
            self.showAlert(title: "삭제", message: "\(item.title)을 정말 삭제하시겠습니까?") {
                self.deleteTodo(item: item)
            }
            completionHandler(true)
        }
        
        deleteAction.backgroundColor = UIColor.red
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}
