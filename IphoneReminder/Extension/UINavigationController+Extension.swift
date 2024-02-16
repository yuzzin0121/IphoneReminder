//
//  UINavigationController+Extension.swift
//  IphoneReminder
//
//  Created by 조유진 on 2/15/24.
//

import UIKit

extension UINavigationController {
    func setupBarAppearence() {
        let appearence = UINavigationBarAppearance()
        appearence.backgroundColor = .black
        navigationBar.standardAppearance = appearence
        navigationBar.scrollEdgeAppearance = appearence


    }
}
