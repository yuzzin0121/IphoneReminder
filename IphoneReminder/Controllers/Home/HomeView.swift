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
    let listTableView = UITableView(frame: .zero, style: .insetGrouped)
    
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
            make.top.equalTo(safeAreaLayoutGuide).inset(24)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(168)
        }
        
        listTableView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide).inset(24)
        }
    }
    
    
    override func configureView() {
        backgroundColor = .black
        collectionView.backgroundColor = .black
        collectionView.isScrollEnabled = false
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        
        listTableView.backgroundColor = .black
        listTableView.layer.cornerRadius = 10
        listTableView.clipsToBounds = true
        listTableView.rowHeight = UITableView.automaticDimension
        listTableView.estimatedRowHeight = 50
        listTableView.showsVerticalScrollIndicator = false
        listTableView.contentInset = .zero
        listTableView.contentInsetAdjustmentBehavior = .never
        listTableView.register(ListItemTableViewCell.self, forCellReuseIdentifier: ListItemTableViewCell.identifier)
    }
}
