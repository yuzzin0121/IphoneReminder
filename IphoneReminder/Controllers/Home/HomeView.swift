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
    
    private func configureCollectionViweFlowLayout()  -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let spacing = 24
        let itemSize: CGFloat = (UIScreen.main.bounds.width - CGFloat(spacing)) / 2
        layout.itemSize = CGSize(width: itemSize, height: 72)
        layout.minimumLineSpacing = 12
        layout.scrollDirection = .vertical
        return layout
    }
    
    override func configureHierarchy() {
        addSubview(collectionView)
    }
    
    override func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(safeAreaLayoutGuide).inset(24)
            make.horizontalEdges.equalToSuperview().inset(6)
        }
    }
    
    override func configureView() {
        backgroundColor = .black
        collectionView.backgroundColor = .black
        collectionView.isScrollEnabled = false
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
    }
}
