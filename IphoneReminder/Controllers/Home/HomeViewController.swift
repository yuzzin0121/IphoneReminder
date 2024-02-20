//
//  HomeViewController.swift
//  IphoneReminder
//
//  Created by 조유진 on 2/15/24.
//

import UIKit
import RealmSwift

struct Category {
    let kind: Kind
    let title: String
    let iconImage: UIImage
    let backgroundColor: UIColor
    var count: Int
}

final class HomeViewController: BaseViewController {
    let mainView = HomeView()
    let kindList = Kind.allCases
    var categoryList = [
        Category(kind: Kind.today, title: Kind.today.title, iconImage: Kind.today.iconImage, backgroundColor: Kind.today.backgroundColor, count: 0),
        Category(kind: Kind.schedule, title: Kind.schedule.title, iconImage: Kind.schedule.iconImage, backgroundColor: Kind.schedule.backgroundColor, count: 0),
        Category(kind: Kind.total, title: Kind.total.title, iconImage: Kind.total.iconImage, backgroundColor: Kind.total.backgroundColor, count: 0),
        Category(kind: Kind.flag, title: Kind.flag.title, iconImage: Kind.flag.iconImage, backgroundColor: Kind.flag.backgroundColor, count: 0),
        Category(kind: Kind.completed, title: Kind.completed.title, iconImage: Kind.completed.iconImage, backgroundColor: Kind.completed.backgroundColor, count: 0)
    ]
    var todoList: Results<TodoModel>!
    var totalCount = 0
    var todoTableRepository = TodoTableRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItem()
        configureCollectionView()
        mainView.newTodoButton.addTarget(self, action: #selector(showAddTodoVC), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
        getTodoData()
        getCompleted()
        getTodayTodo()
        getScheduleTodo()
    }
    
    func getCompleted() {
        categoryList[Kind.completed.rawValue].count = todoTableRepository.fetchCompleted().count
    }
   
    func getTodoData() {
        todoList = todoTableRepository.fetch()
        categoryList[Kind.total.rawValue].count = todoList.count
        print(todoList.count)
        mainView.collectionView.reloadData()
    }
    
    func getTodayTodo() {
        categoryList[Kind.today.rawValue].count = todoTableRepository.fetchTodayTodo().count
    }
    
    func getScheduleTodo() {
        categoryList[Kind.schedule.rawValue].count = todoTableRepository.fetchScheduleTodo().count
    }
    
    func configureCollectionView() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
    
    @objc func showAddTodoVC() {
        let addTodoVC = AddTodoViewController()
        addTodoVC.previousVC = PreviousVC.home
        addTodoVC.completionHandler = {
            self.getTodoData()
        }
        let nav = UINavigationController(rootViewController: addTodoVC)
        present(nav, animated: true)
    }
    
    private func configureNavigationItem() {
        navigationController?.isToolbarHidden = false
        navigationItem.title = "전체"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]

        let editButton = UIBarButtonItem(title: "편집", style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = editButton
        
        let newTodoButton = UIBarButtonItem(customView: mainView.newTodoButton)
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let addListButton = UIBarButtonItem(title: "목록 추가", style: .plain, target: self, action: nil)
        self.toolbarItems = [newTodoButton, flexibleSpace, addListButton]
    }
    
    override func loadView() {
        view = mainView
    }
    
    private func showTodoListVC(kind: Kind) {
        let todoListVC = TodoListViewController()
        todoListVC.type = kind
        navigationController?.pushViewController(todoListVC, animated: true)
    }
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as? CategoryCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let index = indexPath.row
        cell.configureCell(iconImage: categoryList[index].iconImage, backgroundColor: categoryList[index].backgroundColor, title: categoryList[index].title, count: categoryList[index].count)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.row
        showTodoListVC(kind: categoryList[index].kind)
    }
}
