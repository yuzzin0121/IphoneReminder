//
//  ListTodoListViewController.swift
//  IphoneReminder
//
//  Created by 조유진 on 2/22/24.
//

import UIKit

//class ListTodoListViewController: UIViewController {
//    let mainView = ListTodoListView()
//    
//    let filterButton: UIButton = {
//        let button = UIButton()
//        button.setImage(ImageStyle.threeDot, for: .normal)
//        return button
//    }()
//    let filterList = Filter.allCases
//    var todoList: List<TodoModel>!
//    var todoTableRepository = TodoTableRepository()
//    var type: Kind? = nil
//    var previousType: PreviousType? = nil
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        configureFilterButton()
//        configureTableView()
//        configureNavigationItem()
//        if let type {
//            print("이씀")
//            getTodo(type: type)
//        }
//    }
//    
//    private func configureTableView() {
//        mainView.tableView.delegate = self
//        mainView.tableView.dataSource = self
//    }
//    
//    private func configureNavigationItem() {
//        if let type {
//            navigationItem.title = type.title
//        } else {
//            navigationItem.title = "전체"
//        }
//        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
//        let filterbutton = filterButton
//        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: filterbutton)
//    }
//    
//    override func loadView() {
//        view = mainView
//    }
//
//    @objc private func updateIsComplete(sender: UIButton) {
//        let item = todoList[sender.tag]
//        todoTableRepository.updateisCompleted(item)
//        getTotalTodo()
//    }
//
//    private func deleteTodo(item: TodoModel) {
//        todoTableRepository.deleteItem(item)
//        getTotalTodo()
//    }
//    
//    func showAddTodoVC(item: TodoModel) {
//        let addTodoVC = AddTodoViewController()
//        addTodoVC.currentTodo = TodoModel(title: item.title, memo: item.memo, deadLineDate: item.deadLineDate, tag: item.tag, priority: item.priority)
//        addTodoVC.previousVC = PreviousVC.list
//        addTodoVC.image = loadImageToDocument(filename: "\(item.id)")
//        addTodoVC.completionHandler = {
//            if let type = self.type {
//                print("이씀")
//                self.getTodo(type: type)
//            }
//        }
//        let nav = UINavigationController(rootViewController: addTodoVC)
//        present(nav, animated: true)
//    }
//}
//
//// 테이블뷰 설정
//extension TodoListViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return todoList.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: TodoTableViewCell.identifier, for: indexPath) as? TodoTableViewCell else {
//            return UITableViewCell()
//        }
//        cell.selectionStyle = .none
//        cell.backgroundColor = .black
//        let row = todoList[indexPath.row]
//        // 도큐먼트 폴더에 있는 이미지를 셀에 보여주기
//        if let image = loadImageToDocument(filename: "\(row.id)") {
//            cell.selectedimageView.isHidden = false
//            cell.selectedimageView.image = image
//        } else {
//            cell.selectedimageView.isHidden = true
//        }
//        cell.configureCell(todo: row)
//        cell.isCompletedIcon.tag = indexPath.row
//        cell.isCompletedIcon.addTarget(self, action: #selector(updateIsComplete), for: .touchUpInside)
//        
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let item = todoList[indexPath.row]
//        showAddTodoVC(item: item)
//    }
//    
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let deleteAction = UIContextualAction(style: .destructive, title: "삭제하기") {
//            (_,_, completionHandler) in
//            let item = self.todoList[indexPath.row]
//            self.showAlert(title: "삭제", message: "\(item.title)을 정말 삭제하시겠습니까?") {
//                self.removeImageFromDocument(filename: "\(item.id)")
//                self.deleteTodo(item: item)
//            }
//            completionHandler(true)
//        }
//        
//        deleteAction.backgroundColor = UIColor.red
//        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
//        return configuration
//    }
//
//}
