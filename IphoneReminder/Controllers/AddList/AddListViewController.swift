//
//  AddListViewController.swift
//  IphoneReminder
//
//  Created by 조유진 on 2/21/24.
//

import UIKit

enum ColorItem: Int, CaseIterable {
    case red
    case orange
    case yellow
    case green
    case blue
    case purple
    case brown
    
    var name: String {
        switch self {
        case .red: return "customRed"
        case .orange: return "customOrange"
        case .yellow: return "customYellow"
        case .green: return "customGreen"
        case .blue: return "customBlue"
        case .purple: return "customPurple"
        case .brown: return "customBrown"
        }
    }
}

class AddListViewController: BaseViewController {
    let mainView = AddListView()
    lazy var addButton = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(addButtonClicked))
    
    var colorList = ColorItem.allCases
    lazy var selectedColorName = colorList[0].name
    var listName: String?
    var canAddStatus = false
    var listTableRepository = ListTableRepository()
    var completionHandler: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationItem()
        configureDelegate()
        mainView.iconBackgroundView.backgroundColor = UIColor(named: selectedColorName)
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        mainView.listNameTextField.becomeFirstResponder()
    }
    
    override func viewDidLayoutSubviews() {
        DispatchQueue.main.async {
            self.mainView.iconBackgroundView.layer.cornerRadius = self.mainView.iconBackgroundView.frame.height / 2
            self.mainView.iconBackgroundView.clipsToBounds = true
        }
    }
    
    // 추가 버튼 클릭했을 때
    @objc private func addButtonClicked() {
        if let listName {
            let listItem = ListItem(title: listName, colorName: selectedColorName)
            listTableRepository.createItem(listItem)
        }
        completionHandler?()
        dismiss(animated: true)
    }
    
    // 취소 버튼 클릭했을 때
    @objc private func cancelButtonClicked() {
        dismiss(animated: true)
    }
    
    private func configureDelegate() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.listNameTextField.addTarget(self, action: #selector(listNameTextFieldEditingChanged), for: .editingChanged)
    }
    
    @objc private func listNameTextFieldEditingChanged(sender: UITextField) {
        if let text = sender.text {
            navigationItem.rightBarButtonItem?.isEnabled = true
            canAddStatus = true
            listName = text
        } else {
            canAddStatus = false
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
    
    private func configureNavigationItem() {
        navigationItem.title = "새로운 목록"
        
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        let cancelButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelButtonClicked))
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = addButton
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
}


extension AddListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(colorList.count)
        return colorList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colorCell", for: indexPath)
        cell.backgroundColor = UIColor(named: colorList[indexPath.row].name)
        cell.layer.borderWidth = 0
        cell.layer.cornerRadius = cell.contentView.frame.height / 2
        cell.clipsToBounds = true
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colorCell", for: indexPath)
        cell.layer.borderWidth = 2
        cell.layer.borderColor = ColorStyle.customGray.cgColor
        mainView.iconBackgroundView.backgroundColor = UIColor(named: colorList[indexPath.row].name)
        selectedColorName = colorList[indexPath.row].name
    }
    
}
