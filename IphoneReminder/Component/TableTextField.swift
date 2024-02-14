//
//  DarkTextField.swift
//  IphoneReminder
//
//  Created by 조유진 on 2/15/24.
//

import UIKit

class TableTextField: UITextField {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    func configureView() {
        backgroundColor = ColorStyle.deepDarkGray
        textColor = .systemGray6
        font = .systemFont(ofSize: 14)
        isEnabled = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
