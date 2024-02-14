//
//  ReuseProtocol.swift
//  IphoneReminder
//
//  Created by 조유진 on 2/15/24.
//

import UIKit

protocol ReuseProtocol {
    static var identifier: String { get }
}

extension UITableViewCell: ReuseProtocol {
    static var identifier: String {
        String(describing: self)
    }
}

extension UICollectionViewCell: ReuseProtocol {
    static var identifier: String {
        String(describing: self)
    }
}
