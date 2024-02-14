//
//  AddTodoViewController.swift
//  IphoneReminder
//
//  Created by 조유진 on 2/15/24.
//

import UIKit

enum TodoInfo: Int, CaseIterable {
    case memo
    case deadLineDate
    case tag
    case priority
    case addImage
    
    var title: String {
        switch self {
        case .memo: return ""
        case .deadLineDate: return "마감일"
        case .tag: return "태그"
        case .priority: return "우선 순위"
        case .addImage: return "이미지 추가"
        }
    }
    
    var cellHeight: CGFloat {
        switch self {
        case .memo: return 150
        case .deadLineDate, .tag, .priority, .addImage:
            return 54
        }
    }
}

struct Todo {
    var memo: [String: String?]
    var deadLineDate: String
    var tag: String
    var priority: String
    let image: String
}

class AddTodoViewController: BaseViewController {
    let mainView = AddView()
    var todo: Todo = Todo(memo: ["제목":nil, "내용": nil], deadLineDate: "", tag: "", priority: "", image: "")
    var kindList = TodoInfo.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationItem()
        configureTableView()
        NotificationCenter.default.addObserver(self, selector: #selector(setTag), name: NSNotification.Name("setTag"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setPrioirty), name: NSNotification.Name("setPriority"), object: nil)
    }
    
    @objc func setTag(notification: NSNotification) {
        let userInfo = notification.userInfo
        guard let value = userInfo?["tag"] as? String else { return }
        todo.tag = value
        mainView.tableView.reloadRows(at: [IndexPath.init(row: TodoInfo.tag.rawValue, section: 0)], with: .none)
    }
    
    @objc func setPrioirty(notification: NSNotification) {
        let userInfo = notification.userInfo
        guard let value = userInfo?["priority"] as? String else { return }
        todo.priority = value
        mainView.tableView.reloadRows(at: [IndexPath.init(row: TodoInfo.priority.rawValue, section: 0)], with: .none)
    }
    
    func configureTableView() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
    }
    
    @objc func cancelButtonClicked() {
        dismiss(animated: true)
    }
    
    @objc func addButtonClicked() {
        dismiss(animated: true)
    }
    
    private func showEditVC(type: TodoInfo) {
        switch type {
        case .memo:
            showMemoVC()
        case .deadLineDate:
            showDeadLineDateVC()
        case .tag:
            showTagVC()
        case .priority:
            priorityVC()
        case .addImage:
            addImageVC()
        }
    }
    
    private func showMemoVC() {
        let memoVC = MemoViewController()
        memoVC.completionHandler = { title, content in
            self.todo.memo["제목"] = title
            self.todo.memo["내용"] = content
            self.mainView.tableView.reloadRows(at: [IndexPath.init(row: TodoInfo.memo.rawValue, section: 0)], with: .none)
        }
        navigationController?.pushViewController(memoVC, animated: true)
    }
    
    private func showDeadLineDateVC() {
        let deadLineDateVC = DeadLineDateViewController()
        deadLineDateVC.completionHandler = { dateString in
            self.todo.deadLineDate = dateString
            self.mainView.tableView.reloadRows(at: [IndexPath.init(row: TodoInfo.deadLineDate.rawValue, section: 0)], with: .none)
        }
        navigationController?.pushViewController(deadLineDateVC, animated: true)
    }
    
    private func showTagVC() {
        let tagVC = TagViewController()
        navigationController?.pushViewController(tagVC, animated: true)
    }
    
    private func priorityVC() {
        let priorityVC = PriorityViewController()
        navigationController?.pushViewController(priorityVC, animated: true)
    }
    
    private func addImageVC() {
        let addImageVC = AddImageViewController()
        navigationController?.pushViewController(addImageVC, animated: true)
    }
    
    private func configureNavigationItem() {
        navigationItem.title = "새로운 할 일"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    
        let cancelButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelButtonClicked))
        
        let addButton = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(addButtonClicked))
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = addButton
    }
    
    override func loadView() {
        view = mainView
    }

}

extension AddTodoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kindList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if TodoInfo.memo.rawValue == indexPath.row {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MemoTableViewCell.identifier, for: indexPath) as? MemoTableViewCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.backgroundColor = ColorStyle.darkBlack
            if let title = todo.memo["제목"], let memo = todo.memo["내용"] {
                cell.configureCell(title: title, memo: memo)
            }
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: InfoTableViewCell.identifier, for: indexPath) as? InfoTableViewCell else {
                return UITableViewCell()
            }
            
            var value = ""
            
            switch indexPath.row {
            case TodoInfo.deadLineDate.rawValue:
                value = todo.deadLineDate
            case TodoInfo.tag.rawValue:
                value = todo.tag
            case TodoInfo.priority.rawValue:
                value = todo.priority
            default: break
                
            }
            
            cell.selectionStyle = .none
            cell.backgroundColor = ColorStyle.darkBlack
            cell.configureCell(title: kindList[indexPath.row].title, value: value)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kindList[indexPath.row].cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showEditVC(type: kindList[indexPath.row])
    }
    
}
