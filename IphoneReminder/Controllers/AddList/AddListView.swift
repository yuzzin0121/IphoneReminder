//
//  AddListView.swift
//  IphoneReminder
//
//  Created by 조유진 on 2/21/24.
//

import UIKit
import SnapKit

class AddListView: BaseView {
    let listInputBackgroundView = UIView()
    let iconBackgroundView = UIView()
    let listIconImageView = UIImageView()
    let listNameTextField = UITextField()
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViweFlowLayout())
    
    let listNamePlaceholder = "목록 이름"
    
    private func configureCollectionViweFlowLayout()  -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let spacing = 40
        let itemSize: CGFloat = (UIScreen.main.bounds.width-40 - CGFloat(spacing)) / 7
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .vertical
        return layout
    }
    
    override func configureHierarchy() {
        addSubview(listInputBackgroundView)
        listInputBackgroundView.addSubview(iconBackgroundView)
        iconBackgroundView.addSubview(listIconImageView)
        listInputBackgroundView.addSubview(listNameTextField)
        addSubview(collectionView)
    }
    
    override func configureLayout() {
        listInputBackgroundView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(14)
            make.height.greaterThanOrEqualTo(210)
        }
        
        iconBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(listInputBackgroundView).offset(20)
            make.centerX.equalTo(listInputBackgroundView)
            make.size.equalTo(100)
        }
        
        listIconImageView.snp.makeConstraints { make in
            make.size.equalTo(60)
            make.center.equalTo(iconBackgroundView)
        }
        
        listNameTextField.snp.makeConstraints { make in
            make.top.equalTo(iconBackgroundView.snp.bottom).offset(20)
            make.horizontalEdges.bottom.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(listInputBackgroundView.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(14)
            make.height.greaterThanOrEqualTo(142)
        }
    }
    

    
    override func configureView() {
        backgroundColor = ColorStyle.darkBlack
        listInputBackgroundView.backgroundColor = ColorStyle.customDarkGray
        listInputBackgroundView.layer.cornerRadius = 10
        listInputBackgroundView.clipsToBounds = true
        
        listIconImageView.tintColor = .white
        listIconImageView.image = ImageStyle.list
        
        listNameTextField.backgroundColor = ColorStyle.customGray
        listNameTextField.textColor = .systemGray6
        listNameTextField.placeholder = listNamePlaceholder
        listNameTextField.attributedPlaceholder = NSAttributedString(string: listNamePlaceholder,
                                                     attributes: [
                                                        .foregroundColor: UIColor.lightGray
                                                     ])
        listNameTextField.font = .boldSystemFont(ofSize: 24)
        listNameTextField.layer.cornerRadius = 12
        listNameTextField.clipsToBounds = true
        listNameTextField.textAlignment = .center
        
        collectionView.showsVerticalScrollIndicator = false
        collectionView.layer.cornerRadius = 10
        collectionView.clipsToBounds = true
        collectionView.backgroundColor = ColorStyle.customDarkGray
        collectionView.contentInset = UIEdgeInsets(top: 16, left: 20, bottom: 16, right: 20)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "colorCell")
    }
}
