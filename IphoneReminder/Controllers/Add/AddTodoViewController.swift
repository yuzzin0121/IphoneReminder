//
//  AddTodoViewController.swift
//  IphoneReminder
//
//  Created by 조유진 on 2/15/24.
//

import UIKit
import RealmSwift

class AddTodoViewController: BaseViewController {
    let mainView = AddView()
    lazy var cancelButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelButtonClicked))
    lazy var addButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(addButtonClicked))
        var title = ""
        switch previousVC {
        case .home:
            title = "추가"
        case .list:
            title = "수정"
        case nil:
            print("previousVC: nil 절대 안나오겠지")
        }
        button.title = title
        return button
    }()
    var currentTodo = TodoModel(title: nil, memo: nil, deadLineDate: Date(), createdAt: nil, tag: nil, priority: nil)
    var listItem: ListItem? = nil
    var kindList = TodoInfo.allCases
    var isValid: Bool = false {
        didSet {
            print(isValid)
            addButton.isEnabled = isValid ? true : false
        }
    }
    var image: UIImage? = nil
    var completionHandler: (() -> Void)?
    var todoTableRepository = TodoTableRepository()
    var previousVC: PreviousVC? = nil
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        isValid = isValidValue()
        configureNavigationItem()
        configureTableView()
        NotificationCenter.default.addObserver(self, selector: #selector(setTag), name: NSNotification.Name("setTag"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setPrioirty), name: NSNotification.Name("setPriority"), object: nil)
    }
    
    private func isValidValue() -> Bool {
        if let title = currentTodo.title, let tag = currentTodo.tag, let priority = currentTodo.priority {
            return true
        }
        return false
    }
    
    @objc func setTag(notification: NSNotification) {
        let userInfo = notification.userInfo
        guard let value = userInfo?["tag"] as? String else { return }
        currentTodo.tag = value
        isValid = isValidValue()
        mainView.tableView.reloadRows(at: [IndexPath(row: TodoInfo.tag.rawValue, section: 0)], with: .none)
    }
    
    @objc func setPrioirty(notification: NSNotification) {
        let userInfo = notification.userInfo
        guard let value = userInfo?["priority"] as? String else { return }
        currentTodo.priority = value
        isValid = isValidValue()
        mainView.tableView.reloadRows(at: [IndexPath(row: TodoInfo.priority.rawValue, section: 0)], with: .none)
    }
    
    func configureTableView() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
    }
    
    // 취소 버튼 클릭했을 때
    @objc func cancelButtonClicked() {
        dismiss(animated: true)
    }
    
    // MARK: - 추가 버튼 클릭했을 때
    @objc func addButtonClicked() {
        if !isValid { return }
        
        switch previousVC {
        case .home: // 추가일 경우
            if let listItem = listItem {
                todoTableRepository.createItem(currentTodo, listItem: listItem)
            } else {
                todoTableRepository.createItem(currentTodo, listItem: nil)
            }
            // Filemanager를 통해 이미지 파일을 도큐먼트에 저장
            if let image {
                saveImageToDocument(image: image, filename: "\(currentTodo.id)")
            }
        case .list: // 수정일 경우
            if listItem != nil {
                print("listItem nil 아님 - 할일 수정화면")
                todoTableRepository.updateItem(todoModel: currentTodo, listItem: listItem)
            } else {
                print("listItem nil임 - 할일 수정화면")
                todoTableRepository.updateItem(todoModel: currentTodo, listItem: nil)
            }
            if let image {
                saveImageToDocument(image: image, filename: "\(currentTodo.id)")
            }
        case nil:
            fatalError("왜 nil임??;;;ㅠㅠㅠ")
        }

        completionHandler?()
        dismiss(animated: true)
    }
    
//    func setTodo() {
//        if let memoTitle, let tag, let priority {
//            currentTodo = TodoModel(title: memoTitle, memo: memo, deadLineDate: deadLineDate, createdAt: Date(), tag: tag, priority: priority)
//        }
//    }
    
    // 셀 클릭했을 때 타입에 따라 다른 화면으로 이동
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
        case .list:
            showSelectListVC()
        }
    }
    
    // 메모 편집 화면으로 이동
    private func showMemoVC() {
        let memoVC = MemoViewController()
        memoVC.memoTitle = currentTodo.title
        memoVC.memo = currentTodo.memo
        memoVC.completionHandler = { title, content in
            self.currentTodo.title = title
            self.currentTodo.memo = content
            self.isValid = self.isValidValue()
            self.mainView.tableView.reloadRows(at: [IndexPath.init(row: TodoInfo.memo.rawValue, section: 0)], with: .none)
        }
        navigationController?.pushViewController(memoVC, animated: true)
    }
    
    // 마감일 편집 화면으로 이동
    private func showDeadLineDateVC() {
        let deadLineDateVC = DeadLineDateViewController()
        deadLineDateVC.deadLineDate = currentTodo.deadLineDate
        deadLineDateVC.completionHandler = { dateString in
            self.currentTodo.deadLineDate = dateString
            self.isValid = self.isValidValue()
            self.mainView.tableView.reloadRows(at: [IndexPath.init(row: TodoInfo.deadLineDate.rawValue, section: 0)], with: .none)
        }
        navigationController?.pushViewController(deadLineDateVC, animated: true)
    }
    
    // 태그 편집 화면으로 이동
    private func showTagVC() {
        let tagVC = TagViewController()
        tagVC.tag = currentTodo.tag
        navigationController?.pushViewController(tagVC, animated: true)
    }
    
    // 우선순위 편집 화면으로 이동
    private func priorityVC() {
        let priorityVC = PriorityViewController()
//        priorityVC.priority = priority
        navigationController?.pushViewController(priorityVC, animated: true)
    }
    
    // 이미지 추가 화면으로 이동
    private func addImageVC() {
        let addImageVC = AddImageViewController()
        addImageVC.completionHandler = { image in
            self.image = image
            self.isValid = self.isValidValue()
            self.mainView.tableView.reloadRows(at: [IndexPath(row: TodoInfo.addImage.rawValue, section: 0)], with: .automatic)
        }
        navigationController?.pushViewController(addImageVC, animated: true)
    }
    
    private func showSelectListVC() {
        let selectListVC = SelectListViewController()
        if let listItem {
            
        }
        selectListVC.completionHandler = { listItem in
            self.listItem = listItem
            self.isValid = self.isValidValue()
            self.mainView.tableView.reloadRows(at: [IndexPath(row: TodoInfo.list.rawValue, section: 0)], with: .automatic)
        }
        navigationController?.pushViewController(selectListVC, animated: true)
    }
    
    private func changeFormat(date: Date) -> String? {
        // 선택된 날짜를 문자열로 변환하여 출력
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // 원하는 날짜 형식 지정
        return dateFormatter.string(from: date)
    }
    
    private func configureNavigationItem() {

        if let previousVC {
            switch previousVC {
            case .home:
                navigationItem.title = "새로운 할 일"
            case .list:
                navigationItem.title = "할 일 수정"
            }
        } else {
            navigationItem.title = "새로운 할 일"
        }
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = addButton
        navigationItem.rightBarButtonItem?.isEnabled = false
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
            cell.configureCell(title: currentTodo.title, memo: currentTodo.memo)
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: InfoTableViewCell.identifier, for: indexPath) as? InfoTableViewCell else {
                return UITableViewCell()
            }
            
            var value: String? = ""
            
            switch indexPath.row {
            case TodoInfo.deadLineDate.rawValue:
                value = changeFormat(date: currentTodo.deadLineDate ?? Date())
            case TodoInfo.tag.rawValue:
                value = currentTodo.tag
            case TodoInfo.priority.rawValue:
                value = currentTodo.priority
            case TodoInfo.addImage.rawValue:
                if let image {
                    cell.seletecimageView.image = image
                } else {
                    cell.seletecimageView.image = nil
                }
            case TodoInfo.list.rawValue:
                if let listItem {
                    value = listItem.title
                    print("currentListItem: \(value)")
                } else {
                    if let listItem = currentTodo.listItem.first {
                        value = listItem.title
                    }
                }
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
    
    // 셀 클릭했을 때
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showEditVC(type: kindList[indexPath.row])
    }
    
}
