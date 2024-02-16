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
    case rowPriority
    case highPriority
    
    var title: String {
        switch self {
        case .total: return "전체 보기"
        case .deadLine: return "마감일 순으로 보기"
        case .title: return "제목 순으로 보기"
        case .rowPriority: return "우선순위 낮음 만 보기"
        case .highPriority: return "우선순위 높음 만 보기"
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
    var todoList: Results<TodoModel>! {
        didSet {
            mainView.tableView.reloadData()
        }
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

    override func viewDidLoad() {
        super.viewDidLoad()
        configureFilterButton()
        configureTableView()
        configureNavigationItem()
        getTotalTodo()
    }
    
    @objc private func filterButtonClicked() {
        
    }
    
    func configureFilterButton() {
        let seletedPriority = {(action: UIAction) in
                print(action.title)}
        filterButton.menu = UIMenu(children: [
                UIAction(title: "전체보기", state: .on, handler: selectedTotal),
                UIAction(title: "마감일 순으로 보기", handler: selectedDeadLine),
                UIAction(title: "제목 순으로 보기", handler: selectedTotal),
                UIAction(title: "우선순위 낮음 만 보기", handler: selectedTotal),
                UIAction(title: "우선순위 높음 만 보기", handler: selectedHighPriority)])
        filterButton.showsMenuAsPrimaryAction = true
        filterButton.changesSelectionAsPrimaryAction = true
    }
    
    private func getDeadLine() {
        let realm = try! Realm()
        
        todoList = realm.objects(TodoModel.self)
            .sorted(byKeyPath: "deadLineDate", ascending: true)
    }
    
    private func getTitle() {
        let realm = try! Realm()
        
        todoList = realm.objects(TodoModel.self)
            .sorted(byKeyPath: "title", ascending: true)
    }
    
    private func getLowPrioirty() {
        let realm = try! Realm()
        
        todoList = realm.objects(TodoModel.self).where {
            $0.priority == "하"
        }
    }
    private func getHighPrioirty() {
        let realm = try! Realm()
        
        todoList = realm.objects(TodoModel.self).where {
            $0.priority == "상"
        }
    }
    
    private func getTotalTodo() {
        let realm = try! Realm()
        
        todoList = realm.objects(TodoModel.self)
//        mainView.tableView.reloadData()
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
        
        return cell
    }
}
