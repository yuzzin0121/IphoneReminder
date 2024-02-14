//
//  BaseView.swift
//  IphoneReminder
//
//  Created by 조유진 on 2/15/24.
//

import UIKit

class BaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() {
        
    }
    func configureLayout() {
        
    }
    func configureView() {
        backgroundColor = .black
    }
}
