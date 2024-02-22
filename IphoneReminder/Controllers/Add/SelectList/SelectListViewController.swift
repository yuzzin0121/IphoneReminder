//
//  SelectListViewController.swift
//  IphoneReminder
//
//  Created by 조유진 on 2/22/24.
//

import UIKit
import RealmSwift

class SelectListViewController: UIViewController {
    let mainView = SelectListView()
    
    var listItem: ListItem? = nil
    var listList: Results<ListItem>!
    var listTableRepository = ListTableRepository()
    var completionHandler: ((ListItem) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationItem()
        setDelegate()
        fetchList()
        if let listItem = listItem {
            mainView.messageLabel.text = "미리알림이 '\(listItem.title)'에 생성됩니다."
        }
    }
    
    override func loadView() {
        view = mainView
    }
    
    private func fetchList() {
        listList = listTableRepository.fetch()
        
        mainView.tableView.reloadData()
    }
    
    private func setDelegate() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
    }
    
    private func configureNavigationItem() {
        navigationItem.title = "목록"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    private func selectAndPop(list: ListItem) {
        completionHandler?(list)
        navigationController?.popViewController(animated: true)
    }
}

extension SelectListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SelectListTableViewCell.identifier, for: indexPath) as? SelectListTableViewCell else {
            return UITableViewCell()
        }
        
        let row = listList[indexPath.row]
        cell.configureCell(listItem: row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = listList[indexPath.row]
        selectAndPop(list: row)
    }
}
