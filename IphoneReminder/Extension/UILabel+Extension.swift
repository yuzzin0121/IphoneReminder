//
//  UILabel+Extension.swift
//  IphoneReminder
//
//  Created by 조유진 on 2/15/24.
//

import UIKit

extension UILabel {
    func design(font: UIFont, textColor: UIColor = .white) {
        self.font = font
        self.textColor = textColor
    }
    
    func asColor(targetString: String, color: UIColor?) {
        let fullText = text ?? ""
        let range = (fullText as NSString).range(of: targetString)
        let attributedString = NSMutableAttributedString(string: fullText)
        attributedString.addAttribute(.foregroundColor, value: color as Any, range: range)
        attributedText = attributedString
    }
}
