//
//  HomeView.swift
//  IphoneReminder
//
//  Created by 조유진 on 2/15/24.
//

import UIKit
import SnapKit

class HomeView: BaseView {
    let newTodoButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.plain()
        config.title = "새로운 할 일"
        config.image = ImageStyle.plusCircleFill
        config.imagePadding = 12
        button.configuration = config
        return button
    }()
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViweFlowLayout())
    let listTableView = UITableView()
    
    private func configureCollectionViweFlowLayout()  -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let spacing = 12
        let itemSize: CGFloat = (UIScreen.main.bounds.width-40 - CGFloat(spacing)) / 2
        layout.itemSize = CGSize(width: itemSize, height: 78)
        layout.minimumLineSpacing = 12
        layout.scrollDirection = .vertical
        return layout
    }
    
    override func configureHierarchy() {
        addSubview(collectionView)
        addSubview(listTableView)
    }
    
    override func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(safeAreaLayoutGuide).inset(24)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.greaterThanOrEqualTo(190)
        }
        
        listTableView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(16)
        }
    }
    
    override func configureView() {
        backgroundColor = .black
        collectionView.backgroundColor = .black
        collectionView.isScrollEnabled = false
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        
        listTableView.backgroundColor = .gray
        listTableView.showsVerticalScrollIndicator = false
        listTableView.register(UITableViewCell.self, forCellReuseIdentifier: "listCell")
    }
}
