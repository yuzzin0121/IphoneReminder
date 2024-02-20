//
//  TotalViewController.swift
//  IphoneReminder
//
//  Created by 조유진 on 2/15/24.
//

import UIKit
import RealmSwift

class TodoListViewController: BaseViewController {
    let mainView = TodoListView()
    let filterButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageStyle.threeDot, for: .normal)
        return button
    }()
    let filterList = Filter.allCases
    var todoList: Results<TodoModel>!
    var todoTableRepository = TodoTableRepository()
    var type: Kind? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        configureFilterButton()
        configureTableView()
        configureNavigationItem()
        if let type {
            print("이씀")
            getTodo(type: type)
        }
    }
    
    func getTodo(type: Kind) {
        switch type {
        case .today:
            todoList = todoTableRepository.fetchTodayTodo()
        case .schedule:
            todoList = todoTableRepository.fetchScheduleTodo()
        case .total:
            todoList = todoTableRepository.fetch()
        case .flag:
            break
        case .completed:
            todoList = todoTableRepository.fetchCompleted()
        }
        mainView.tableView.reloadData()
    }
    
    func configureFilterButton() {
        filterButton.menu = UIMenu(children: [
            UIAction(title: Filter.total.title, state: .on, handler: selectedTotal),
            UIAction(title: Filter.deadLine.title, handler: selectedDeadLine),
            UIAction(title: Filter.title.title, handler: selectedTitle),
            UIAction(title: Filter.lowPriority.title, handler: selectedLowPriority),
            UIAction(title: Filter.highPriority.title, handler: selectedHighPriority)])
        filterButton.showsMenuAsPrimaryAction = true
        filterButton.changesSelectionAsPrimaryAction = true
    }
    
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
    
    private func getDeadLine() {
        let sortKey = Filter.deadLine.sortKey
        switch type {
        case .today:
            todoList = todoTableRepository.fetchTodaySortData(key: sortKey)
        case .schedule:
            todoList = todoTableRepository.fetchScheduleSortData(key: sortKey)
        case .total:
            todoList = todoTableRepository.sortData(key: sortKey)
        case .flag:
            break
        case .completed:
            todoList = todoTableRepository.fetchCompletedSortData(key: sortKey)
        case nil:
            return
        }
        mainView.tableView.reloadData()
    }
    
    private func getTitle() {
        let sortKey = Filter.title.sortKey
        switch type {
        case .today:
            todoList = todoTableRepository.fetchTodaySortData(key: sortKey)
        case .schedule:
            todoList = todoTableRepository.fetchScheduleSortData(key: sortKey)
        case .total:
            todoList = todoTableRepository.sortData(key: sortKey)
        case .flag:
            break
        case .completed:
            todoList = todoTableRepository.fetchCompletedSortData(key: sortKey)
        case nil:
            return
        }
        mainView.tableView.reloadData()
    }
    
    private func getLowPrioirty() {
        let sortKey = Filter.lowPriority.sortKey
        switch type {
        case .today:
            todoList = todoTableRepository.fetchTodayPriorityFilter(sortKey)
        case .schedule:
            todoList = todoTableRepository.fetchSchedulePriorityFilter(sortKey)
        case .total:
            todoList = todoTableRepository.fetchPriorityFilter(sortKey)
        case .flag:
            break
        case .completed:
            todoList = todoTableRepository.fetchCompletedPriorityFilter(sortKey)
        case nil:
            return
        }
        mainView.tableView.reloadData()
    }
    
    private func getHighPrioirty() {
        let sortKey = Filter.highPriority.sortKey
        switch type {
        case .today:
            todoList = todoTableRepository.fetchTodayPriorityFilter(sortKey)
        case .schedule:
            todoList = todoTableRepository.fetchSchedulePriorityFilter(sortKey)
        case .total:
            todoList = todoTableRepository.fetchPriorityFilter(sortKey)
        case .flag:
            break
        case .completed:
            todoList = todoTableRepository.fetchCompletedPriorityFilter(sortKey)
        case nil:
            return
        }
        mainView.tableView.reloadData()
    }
    
    private func getTotalTodo() {
        if let type = type {
            getTodo(type: type)
        }
    }
    
    private func configureTableView() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
    }
    
    private func configureNavigationItem() {
        if let type {
            navigationItem.title = type.title
        } else {
            navigationItem.title = "전체"
        }
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        let filterbutton = filterButton
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: filterbutton)
    }
    
    override func loadView() {
        view = mainView
    }

    @objc private func updateIsComplete(sender: UIButton) {
        let item = todoList[sender.tag]
        todoTableRepository.updateisCompleted(item)
        getTotalTodo()
    }

    private func deleteTodo(item: TodoModel) {
        todoTableRepository.deleteItem(item)
        getTotalTodo()
    }
    
    func showAddTodoVC(item: TodoModel) {
        let addTodoVC = AddTodoViewController()
        addTodoVC.previousVC = PreviousVC.list
        addTodoVC.memoTitle = item.title
        addTodoVC.memo = item.memo
        addTodoVC.deadLineDate = item.deadLineDate
        addTodoVC.tag = item.tag
        addTodoVC.priority = item.priority
        addTodoVC.image = loadImageToDocument(filename: "\(item.id)")
        addTodoVC.completionHandler = {
            if let type = self.type {
                print("이씀")
                self.getTodo(type: type)
            }
        }
        let nav = UINavigationController(rootViewController: addTodoVC)
        present(nav, animated: true)
    }
}

// 테이블뷰 설정
extension TodoListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TodoTableViewCell.identifier, for: indexPath) as? TodoTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.backgroundColor = .black
        let row = todoList[indexPath.row]
        // 도큐먼트 폴더에 있는 이미지를 셀에 보여주기
        if let image = loadImageToDocument(filename: "\(row.id)") {
            cell.selectedimageView.isHidden = false
            cell.selectedimageView.image = image
        } else {
            cell.selectedimageView.isHidden = true
        }
        cell.configureCell(todo: row)
        cell.isCompletedIcon.tag = indexPath.row
        cell.isCompletedIcon.addTarget(self, action: #selector(updateIsComplete), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = todoList[indexPath.row]
        showAddTodoVC(item: item)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "삭제하기") {
            (_,_, completionHandler) in
            let item = self.todoList[indexPath.row]
            self.showAlert(title: "삭제", message: "\(item.title)을 정말 삭제하시겠습니까?") {
                self.removeImageFromDocument(filename: "\(item.id)")
                self.deleteTodo(item: item)
            }
            completionHandler(true)
        }
        
        deleteAction.backgroundColor = UIColor.red
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}
