//
//  addImageButton.swift
//  IphoneReminder
//
//  Created by 조유진 on 2/20/24.
//

import UIKit

class AddImageButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        backgroundColor = ColorStyle.deepDarkGray
        setTitleColor(.white, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        layer.cornerRadius = 8
        clipsToBounds = true
    }
}
