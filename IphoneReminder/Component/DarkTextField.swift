//
//  DarkTextField.swift
//  IphoneReminder
//
//  Created by 조유진 on 2/15/24.
//

import UIKit

class DarkTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    func configureView() {
        textColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
