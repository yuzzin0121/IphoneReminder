//
//  AddTodoViewController.swift
//  IphoneReminder
//
//  Created by 조유진 on 2/15/24.
//

import UIKit
import RealmSwift

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

class AddTodoViewController: BaseViewController {
    let mainView = AddView()
    lazy var cancelButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelButtonClicked))
    lazy var addButton = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(addButtonClicked))
    
    var kindList = TodoInfo.allCases
    var todo: TodoModel? = nil
    var memoTitle: String?
    var memo: String?
    var deadLineDate = Date()
    var tag: String?
    var priority: String?
    var isValid: Bool = false {
        didSet {
            print(isValid)
            addButton.isEnabled = isValid ? true : false
        }
    }
    var image: UIImage? = nil
    var completionHandler: (() -> Void)?
    var todoTableRepository = TodoTableRepository()
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationItem()
        configureTableView()
        NotificationCenter.default.addObserver(self, selector: #selector(setTag), name: NSNotification.Name("setTag"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setPrioirty), name: NSNotification.Name("setPriority"), object: nil)
    }
    
    private func isValidValue() -> Bool {
        if let memoTitle, let tag, let priority {
            return true
        }
        return false
    }
    
    @objc func setTag(notification: NSNotification) {
        let userInfo = notification.userInfo
        guard let value = userInfo?["tag"] as? String else { return }
        tag = value
        isValid = isValidValue()
        mainView.tableView.reloadRows(at: [IndexPath.init(row: TodoInfo.tag.rawValue, section: 0)], with: .none)
    }
    
    @objc func setPrioirty(notification: NSNotification) {
        let userInfo = notification.userInfo
        guard let value = userInfo?["priority"] as? String else { return }
        priority = value
        isValid = isValidValue()
        mainView.tableView.reloadRows(at: [IndexPath.init(row: TodoInfo.priority.rawValue, section: 0)], with: .none)
    }
    
    func configureTableView() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
    }
    
    // 취소 버튼 클릭했을 때
    @objc func cancelButtonClicked() {
        dismiss(animated: true)
    }
    
    // 추가 버튼 클릭했을 때
    @objc func addButtonClicked() {
        setTodo()
    
        guard let todo = todo else { return }
        todoTableRepository.createItem(todo)
        // Filemanager를 통해 이미지 파일을 도큐먼트에 저장
        if let image {
            saveImageToDocument(image: image, filename: "\(todo.id)")
        }
        completionHandler?()
        dismiss(animated: true)
    }
    
    func setTodo() {
        if let memoTitle, let tag, let priority {
            todo = TodoModel(title: memoTitle, memo: memo, deadLineDate: deadLineDate, createdAt: Date(), tag: tag, priority: priority)
        }
    }
    
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
        }
    }
    
    // 메모 편집 화면으로 이동
    private func showMemoVC() {
        let memoVC = MemoViewController()
        memoVC.completionHandler = { title, content in
            self.memoTitle = title
            self.memo = content
            self.isValid = self.isValidValue()
            self.mainView.tableView.reloadRows(at: [IndexPath.init(row: TodoInfo.memo.rawValue, section: 0)], with: .none)
        }
        navigationController?.pushViewController(memoVC, animated: true)
    }
    
    // 마감일 편집 화면으로 이동
    private func showDeadLineDateVC() {
        let deadLineDateVC = DeadLineDateViewController()
        deadLineDateVC.completionHandler = { dateString in
            self.deadLineDate = dateString
            self.isValid = self.isValidValue()
            self.mainView.tableView.reloadRows(at: [IndexPath.init(row: TodoInfo.deadLineDate.rawValue, section: 0)], with: .none)
        }
        navigationController?.pushViewController(deadLineDateVC, animated: true)
    }
    
    // 태그 편집 화면으로 이동
    private func showTagVC() {
        let tagVC = TagViewController()
        navigationController?.pushViewController(tagVC, animated: true)
    }
    
    // 우선순위 편집 화면으로 이동
    private func priorityVC() {
        let priorityVC = PriorityViewController()
        navigationController?.pushViewController(priorityVC, animated: true)
    }
    
    // 이미지 추가 화면으로 이동
    private func addImageVC() {
        let addImageVC = AddImageViewController()
        addImageVC.completionHandler = { image in
            self.image = image
            self.mainView.tableView.reloadRows(at: [IndexPath(row: TodoInfo.addImage.rawValue, section: 0)], with: .automatic)
        }
        navigationController?.pushViewController(addImageVC, animated: true)
    }
    
    private func changeFormat(date: Date) -> String? {
        // 선택된 날짜를 문자열로 변환하여 출력
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // 원하는 날짜 형식 지정
        return dateFormatter.string(from: date)
    }
    
    private func configureNavigationItem() {
        navigationItem.title = "새로운 할 일"
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
            cell.configureCell(title: memoTitle, memo: memo)
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: InfoTableViewCell.identifier, for: indexPath) as? InfoTableViewCell else {
                return UITableViewCell()
            }
            
            var value: String? = ""
            
            switch indexPath.row {
            case TodoInfo.deadLineDate.rawValue:
                value = changeFormat(date: deadLineDate ?? Date())
            case TodoInfo.tag.rawValue:
                value = tag
            case TodoInfo.priority.rawValue:
                value = priority
            case TodoInfo.addImage.rawValue:
                if let image {
                    cell.seletecimageView.image = image
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
