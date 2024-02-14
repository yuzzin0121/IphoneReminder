//
//  HomeViewController.swift
//  IphoneReminder
//
//  Created by 조유진 on 2/15/24.
//

import UIKit

enum Kind: Int, CaseIterable {
    case today
    case schedule
    case total
    case flag
    case completed
    
    var title: String {
        switch self {
        case .today: return "오늘"
        case .schedule: return "예정"
        case .total: return "전체"
        case .flag: return "깃발 표시"
        case .completed: return "완료됨"
        }
    }
    
    var iconImage: UIImage {
        switch self {
        case .today:
            return ImageStyle.lightbulbCircleFill
        case .schedule:
            return ImageStyle.calendarCircleFill
        case .total:
            return ImageStyle.trayCircleFill
        case .flag:
            return ImageStyle.flagCircleFill
        case .completed:
            return ImageStyle.checkmarkCircleFill
        }
    }
    
    var tintColor: UIColor {
        switch self {
        case .today:
            return .blue
        case .schedule:
            return .systemRed
        case .total:
            return .gray
        case .flag:
            return .yellow
        case .completed:
            return .orange
        }
    }
}

final class HomeViewController: BaseViewController {
    let mainView = HomeView()
    let kindList = Kind.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItem()
        configureCollectionView()
        mainView.newTodoButton.addTarget(self, action: #selector(showAddTodoVC), for: .touchUpInside)
    }
    
    func configureCollectionView() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
    
    @objc func showAddTodoVC() {
        let addTodoVC = AddTodoViewController()
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
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return kindList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as? CategoryCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let index = indexPath.row
        cell.configureCell(iconImage: kindList[index].iconImage, tintColor: kindList[index].tintColor, title: kindList[index].title, count: 0)
        
        return cell
    }
    
    
}
